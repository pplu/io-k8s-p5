package IO::K8s::Role::Routable;
# ABSTRACT: Role for building HTTP/gRPC routing rules
our $VERSION = '1.108';
use Carp qw( croak );
# Imports above `use Moo::Role` on purpose: Role::Tiny treats subs already in
# the package as not-methods, so their names stay off every consumer. A `use`
# below that line composes its exports onto all shipped classes (k118).
use Moo::Role;

requires '_route_format';

# The fluent setters below build the spec through IO::K8s::Role::SpecBuilder
# rather than by hand, so that role is a hard dependency of this one (k103).
# IO::K8s::Role::APIObject composes SpecBuilder for every top-level Kind, so
# these are satisfied for anything built with IO::K8s::APIObject; a class
# that composes this role without them now fails at composition time,
# naming the missing method, instead of at the first setter call.
requires qw( spec_get spec_push spec_set );

# The 'ingress' branch builds core networking.k8s.io/v1 objects by name, and
# a role cannot `use` them at the top: composing this role would then drag
# the whole Ingress class family into every Gateway API and Traefik consumer
# that never touches that branch. Loaded on the branch that needs them
# instead, the way IO::K8s::Role::APIObject loads ObjectMeta/OwnerReference
# and IO::K8s::Role::NetworkPolicy loads its own spec class. Until k117 they
# were simply not loaded at all, and every one of these methods died with
# 'Can't locate object method "new" via package ...IngressRule' in a process
# that had not happened to load the class for another reason.
#
# Also the single place the ingress spec is vivified; before k117 the same
# five lines sat inlined in three method bodies.
sub _ensure_ingress_spec {
    my ($self) = @_;
    require IO::K8s::Api::Networking::V1::IngressSpec;
    require IO::K8s::Api::Networking::V1::IngressRule;
    require IO::K8s::Api::Networking::V1::IngressBackend;
    require IO::K8s::Api::Networking::V1::IngressServiceBackend;
    require IO::K8s::Api::Networking::V1::ServiceBackendPort;
    # HTTPIngressRuleValue and HTTPIngressPath are deliberately absent: the
    # only branch that constructed them was add_path_match's, which cannot
    # build a path at all (see there). Add them back with the code that
    # needs them, not before.

    my $spec = $self->spec;
    return $spec if $spec;
    $spec = IO::K8s::Api::Networking::V1::IngressSpec->new;
    $self->spec($spec);
    return $spec;
}

=method add_hostname

    $route->add_hostname('example.com', 'api.example.com');

Adds hostnames the route should match. The role dispatches on
C<_route_format>:

=over

=item * C<'gateway'> -- Gateway API HTTPRoute. Appends to
C<spec.hostnames>. Each hostname becomes its own entry on the
C<hostnames> list.

=item * C<'traefik'> -- Traefik IngressRoute. Adds a new C<routes> entry
whose C<match> string combines each hostname with C<Host(`...`)>, e.g.
C<< match =E<gt> 'Host(`example.com`), Host(`api.example.com`)' >>.

=item * C<'ingress'> -- core Kubernetes Ingress. Appends an
L<IO::K8s::Api::Networking::V1::IngressRule> per hostname with
C<host =E<gt> $hostname>.

=back

Returns C<$self> for chaining.

    $route->add_hostname('example.com');

=cut

sub add_hostname {
    my ($self, @hostnames) = @_;
    my $format = $self->_route_format;
    if ($format eq 'gateway') {
        $self->spec_push('hostnames', @hostnames);
    } elsif ($format eq 'traefik') {
        # Traefik uses match rules like Host(`example.com`)
        # We add a route with the host match
        my $hosts = join ', ', map { "Host(`$_`)" } @hostnames;
        $self->spec_push('routes', { match => $hosts, kind => 'Rule', services => [] });
    } elsif ($format eq 'ingress') {
        my $spec = $self->_ensure_ingress_spec;
        my $rules = $spec->rules // [];
        for my $hostname (@hostnames) {
            push @$rules, IO::K8s::Api::Networking::V1::IngressRule->new(
                host => $hostname,
            );
        }
        $spec->rules($rules);
    }
    return $self;
}

=method add_backend

    $route->add_backend('api-v1', port => 8080, weight => 90);

Adds a backend the route should dispatch traffic to. C<name> is required;
C<port> and C<weight> are optional. Dispatch is per format:

=over

=item * C<'gateway'> -- appends to the last rule's C<backendRefs> as
C<< { name, port, weight } >>.

=item * C<'traefik'> -- appends to the last route's C<services> as
C<< { name, port, weight } >>.

=item * C<'ingress'> -- replaces C<spec.defaultBackend> with a typed
IngressBackend / IngressServiceBackend / ServiceBackendPort chain, using
the last C<name> and C<port>.

=back

Returns C<$self> for chaining.

    $route->add_backend('api-v1', port => 8080, weight => 90);

=cut

sub add_backend {
    my ($self, $name, %opts) = @_;
    my $format = $self->_route_format;
    my %backend = (
        name => $name,
        $opts{port}   ? (port   => $opts{port})   : (),
        $opts{weight} ? (weight => $opts{weight}) : (),
    );
    if ($format eq 'gateway') {
        $self->spec_push('rules.-1.backendRefs', \%backend);
    } elsif ($format eq 'traefik') {
        $self->spec_push('routes.-1.services', \%backend);
    } elsif ($format eq 'ingress') {
        my $spec = $self->_ensure_ingress_spec;
        $spec->defaultBackend(IO::K8s::Api::Networking::V1::IngressBackend->new(
            service => IO::K8s::Api::Networking::V1::IngressServiceBackend->new(
                name => $name,
                port => IO::K8s::Api::Networking::V1::ServiceBackendPort->new(
                    number => $opts{port},
                ),
            ),
        ));
    }
    return $self;
}

=method add_path_match

    $route->add_path_match('/api', type => 'Prefix');

Adds a path match to the most recently added routing rule. C<$path> is
required; C<type> defaults to C<'Prefix'> and selects one of:

=over

=item * C<'Prefix'> -- Gateway API C<< { path: { type: 'PathPrefix', value } } >>,
Traefik C<PathPrefix(`...`)>.

=item * C<'Exact'> -- Traefik C<Path(`...`)>.

=item * C<'Regex'> -- Traefik C<PathRegexp(`...`)>.

=back

Returns C<$self> for chaining.

Not available in C<'ingress'> mode: a
L<IO::K8s::Api::Networking::V1::HTTPIngressPath> requires a C<backend> as
well as a C<pathType>, and this method has no parameter that could carry
one -- C<add_backend> writes C<spec.defaultBackend>, which is the
fallback for unmatched requests rather than a path's own backend. The
call croaks, leaving the object untouched (k117; before that it croaked
too, but only after vivifying C<spec> and appending a rule). Build
C<spec.rules> yourself for a path-routed Ingress.

=cut

sub add_path_match {
    my ($self, $path, %opts) = @_;
    my $type = $opts{type} // 'Prefix';
    my $format = $self->_route_format;
    if ($format eq 'gateway') {
        # This role's own vocabulary (Prefix/Exact/Regex, documented above)
        # is not the Gateway API HTTPPathMatch.type enum (Exact/PathPrefix/
        # RegularExpression, k95/D5) -- translate it the same way the
        # 'traefik' branch below translates it into Traefik's match syntax.
        my $gw_type = $type eq 'Prefix' ? 'PathPrefix'
                    : $type eq 'Regex'  ? 'RegularExpression'
                    : $type;    # 'Exact' is spelled the same in both vocabularies
        $self->spec_push('rules.-1.matches', { path => { type => $gw_type, value => $path } });
    } elsif ($format eq 'traefik') {
        my $match = $type eq 'Prefix' ? "PathPrefix(`$path`)"
                  : $type eq 'Exact'  ? "Path(`$path`)"
                  : $type eq 'Regex'  ? "PathRegexp(`$path`)"
                  : undef;
        $self->spec_set('routes.-1.match', $match) if defined $match;
    } elsif ($format eq 'ingress') {
        # networking.k8s.io/v1 HTTPIngressPath requires `backend` as well as
        # `pathType`, and this method carries no parameter that could supply
        # one -- add_backend writes spec.defaultBackend, which is the
        # fallback for unmatched requests, not a path's backend. So an
        # ingress path is not expressible here and the call cannot succeed.
        #
        # It never could: before k117 the branch vivified spec, appended an
        # IngressRule and hung an empty http.paths off it, and only then
        # died inside HTTPIngressPath->new for the missing backend -- a
        # croak the caller could not act on, over an object left half
        # written. Refusing up front is the same outcome minus the damage
        # (validate, then write). Whether the method should instead take a
        # backend is an API decision, not this fix's to make.
        croak __PACKAGE__.'->add_path_match cannot build an ingress path:'
            . ' networking.k8s.io/v1 HTTPIngressPath requires a backend and'
            . ' this method has no parameter for one; build spec.rules'
            . ' yourself, or use add_backend for spec.defaultBackend';
    }
    return $self;
}

=method add_header_match

    $route->add_header_match('X-Env', 'production');

Adds a header-based match to the most recently added routing rule.
Gateway API appends to the last match's C<headers> array as
C<< { name =E<gt> $header, value =E<gt> $value } >>; Traefik extends the
route's C<match> string with C<< && Header(`<name>`, `<value>`) >>.
Core Ingress does not support header matching natively and the call is a
no-op in that mode. Returns C<$self> for chaining.

=cut

sub add_header_match {
    my ($self, $header, $value) = @_;
    my $format = $self->_route_format;
    if ($format eq 'gateway') {
        $self->spec_push('rules.-1.matches.-1.headers', { name => $header, value => $value });
    } elsif ($format eq 'traefik') {
        my $existing = $self->spec_get('routes.-1.match') // '';
        my $header_match = "Header(`$header`, `$value`)";
        $self->spec_set('routes.-1.match', $existing ? "$existing && $header_match" : $header_match);
    }
    # Ingress doesn't support header matching natively
    return $self;
}

1;

__END__

=head1 SYNOPSIS

    package My::Route;
    use IO::K8s::APIObject api_version => 'gateway.networking.k8s.io/v1';
    with 'IO::K8s::Role::Routable';

    sub _route_format { 'gateway' }   # or 'traefik', 'ingress'

    # The full chain below is available for gateway and traefik. In ingress
    # mode add_path_match croaks because a path needs its own backend.

    package main;
    my $r = My::Route->new;
    $r->add_hostname('example.com')
      ->add_backend('api-v1', port => 8080, weight => 90)
      ->add_path_match('/api', type => 'Prefix')
      ->add_header_match('X-Env', 'production');

=head1 DESCRIPTION

This role provides the fluent HTTP routing builders documented in the
README's "HTTP routing" section. Gateway API HTTPRoute and Traefik
IngressRoute support the full chain below; core Kubernetes Ingress supports
the hostname and default-backend helpers but C<add_path_match> croaks because
an Ingress path needs its own backend. The role dispatches on
C<_route_format>, which the consumer must implement and return as one of
C<'gateway'>, C<'traefik'>, or C<'ingress'>.

The three backends produce three different wire shapes:

=over

=item * C<'gateway'> writes through L<IO::K8s::Role::SpecBuilder>'s
C<spec_*> methods into a C<spec> that mirrors the HTTPRoute wire schema
(C<hostnames>, C<rules[].matches[].path>, C<rules[].backendRefs>) --
either a plain hash or a typed struct.

=item * C<'traefik'> writes the same way into a C<spec> that mirrors the
IngressRoute wire schema (C<routes[].match> as a Traefik expression,
C<routes[].services[]>).

=item * C<'ingress'> builds typed L<IO::K8s::Api::Networking::V1::IngressSpec>
/ C<IngressRule> / C<IngressBackend> / C<IngressServiceBackend> /
C<ServiceBackendPort> objects and assembles them into the typed Ingress
shape. C<add_path_match> is the exception and croaks in this mode; see
there. The classes are loaded when the branch first runs, not at
composition time, so composing this role onto a Gateway API or Traefik
Kind pulls none of them in.

=back

Most methods modify the C<last> rule in C<spec.rules> (Gateway / Ingress)
or C<spec.routes> (Traefik), so chain calls in declaration order produce
the natural top-to-bottom manifest.

=head1 REQUIRED METHODS

=head2 _route_format

Must return C<'gateway'>, C<'traefik'>, or C<'ingress'>. The role
dispatches all method bodies on this answer; a missing or unknown value
is treated as a no-op.

=head1 SEE ALSO

L<IO::K8s::GatewayAPI>, L<IO::K8s::Traefik>,
L<IO::K8s::Api::Networking::V1::IngressSpec>, L<IO::K8s::APIObject>

=cut