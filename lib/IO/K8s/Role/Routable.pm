package IO::K8s::Role::Routable;
# ABSTRACT: Role for building HTTP/gRPC routing rules
our $VERSION = '1.108';
use Moo::Role;

requires '_route_format';

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
        my $spec = $self->spec;
        unless ($spec) {
            require IO::K8s::Api::Networking::V1::IngressSpec;
            $spec = IO::K8s::Api::Networking::V1::IngressSpec->new;
            $self->spec($spec);
        }
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
        # For Ingress, add to the last rule's paths
        my $spec = $self->spec;
        unless ($spec) {
            require IO::K8s::Api::Networking::V1::IngressSpec;
            $spec = IO::K8s::Api::Networking::V1::IngressSpec->new;
            $self->spec($spec);
        }
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
Traefik C<PathPrefix(`...`)>, Ingress C<pathType =E<gt> 'Prefix'>.

=item * C<'Exact'> -- Traefik C<Path(`...`)>.

=item * C<'Regex'> -- Traefik C<PathRegexp(`...`)>.

=back

The Ingress path is the only mode that creates a typed
L<IO::K8s::Api::Networking::V1::HTTPIngressPath> on the way through.
Returns C<$self> for chaining.

=cut

sub add_path_match {
    my ($self, $path, %opts) = @_;
    my $type = $opts{type} // 'Prefix';
    my $format = $self->_route_format;
    if ($format eq 'gateway') {
        $self->spec_push('rules.-1.matches', { path => { type => $type, value => $path } });
    } elsif ($format eq 'traefik') {
        my $match = $type eq 'Prefix' ? "PathPrefix(`$path`)"
                  : $type eq 'Exact'  ? "Path(`$path`)"
                  : $type eq 'Regex'  ? "PathRegexp(`$path`)"
                  : undef;
        $self->spec_set('routes.-1.match', $match) if defined $match;
    } elsif ($format eq 'ingress') {
        my $spec = $self->spec;
        unless ($spec) {
            require IO::K8s::Api::Networking::V1::IngressSpec;
            $spec = IO::K8s::Api::Networking::V1::IngressSpec->new;
            $self->spec($spec);
        }
        my $rules = $spec->rules // [];
        # Add path to the last rule, or create new one
        my $rule = @$rules ? $rules->[-1] : IO::K8s::Api::Networking::V1::IngressRule->new;
        push @$rules, $rule unless @$rules;
        my $http = $rule->http;
        unless ($http) {
            $http = IO::K8s::Api::Networking::V1::HTTPIngressRuleValue->new(paths => []);
            $rule->http($http);
        }
        my $paths = $http->paths // [];
        push @$paths, IO::K8s::Api::Networking::V1::HTTPIngressPath->new(
            path     => $path,
            pathType => $type,
        );
        $http->paths($paths);
        $spec->rules($rules);
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

    package main;
    my $r = My::Route->new;
    $r->add_hostname('example.com')
      ->add_backend('api-v1', port => 8080, weight => 90)
      ->add_path_match('/api', type => 'Prefix')
      ->add_header_match('X-Env', 'production');

=head1 DESCRIPTION

This role provides the fluent HTTP routing builders documented in the
README's "HTTP routing" section. The same chain works against Gateway API
HTTPRoute, Traefik IngressRoute, and core Kubernetes Ingress -- the role
dispatches on C<_route_format>, which the consumer must implement and
return as one of C<'gateway'>, C<'traefik'>, or C<'ingress'>.

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
/ C<IngressRule> / C<HTTPIngressRuleValue> / C<HTTPIngressPath> /
C<IngressBackend> / C<IngressServiceBackend> / C<ServiceBackendPort>
objects and assembles them into the typed Ingress shape.

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