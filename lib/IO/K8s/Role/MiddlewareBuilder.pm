package IO::K8s::Role::MiddlewareBuilder;
# ABSTRACT: Role for building Traefik middleware configuration
our $VERSION = '1.108';
use Moo::Role;

=method rate_limit

    $mw->rate_limit(average => $n, burst => $n, period => $duration);

Configures the Traefik rateLimit middleware. C<average> is the allowed
average request rate and C<burst> the maximum instantaneous queue depth;
C<period> is the averaging window and is optional. Only the keys you pass
appear in the resulting C<spec.rateLimit> hash, so an empty call
(C<rate_limit()>) writes a C<< {} >> rather than a populated block. Returns
C<$self> for chaining.

    $mw->rate_limit(average => 100, burst => 200, period => '1s');

=cut

sub rate_limit {
    my ($self, %opts) = @_;
    $self->spec_set('rateLimit', {
        $opts{average} ? (average => $opts{average}) : (),
        $opts{burst}   ? (burst   => $opts{burst})   : (),
        $opts{period}  ? (period  => $opts{period})  : (),
    });
    return $self;
}

=method basic_auth

    $mw->basic_auth(secret => $name, realm => $string);

Configures the Traefik basicAuth middleware. C<secret> is the name of a
Kubernetes Secret containing the htpasswd file; C<realm> is the
authentication realm shown to the user (optional). Returns C<$self> for
chaining.

    $mw->basic_auth(secret => 'admins', realm => 'Admin Area');

=cut

sub basic_auth {
    my ($self, %opts) = @_;
    $self->spec_set('basicAuth', {
        $opts{secret} ? (secret => $opts{secret}) : (),
        $opts{realm}  ? (realm  => $opts{realm})  : (),
    });
    return $self;
}

=method strip_prefix

    $mw->strip_prefix(@prefixes);

Configures the Traefik stripPrefix middleware to remove each prefix in
C<@prefixes> from incoming request paths. The prefixes are written as a
single C<< { prefixes =E<gt> [...] } >> block, replacing any prior
stripPrefix block. Pass an empty list to emit an empty
C<stripPrefix.prefixes> array. Returns C<$self> for chaining.

    $mw->strip_prefix('/api', '/v1');

=cut

sub strip_prefix {
    my ($self, @prefixes) = @_;
    $self->spec_set('stripPrefix', { prefixes => \@prefixes });
    return $self;
}

=method redirect_https

    $mw->redirect_https;

Configures the Traefik redirectScheme middleware to issue a permanent 301
redirect from the current listener to C<https>. The wire block is
C<< { scheme =E<gt> 'https', permanent =E<gt> 1 } >>. Returns C<$self> for
chaining.

=cut

sub redirect_https {
    my ($self) = @_;
    $self->spec_set('redirectScheme', { scheme => 'https', permanent => 1 });
    return $self;
}

=method add_request_header

    $mw->add_request_header($key, $value);

Adds a header that Traefik will inject into every request as it forwards
to the upstream backend. Writes the
C<spec.headers.customRequestHeaders.$key = $value> shape. If the same
C<$key> is added twice the last value wins. Returns C<$self> for chaining.

    $mw->add_request_header('X-Forwarded-User', 'anonymous');

=cut

sub add_request_header {
    my ($self, $key, $value) = @_;
    # Header names may legally contain dots; write into the map directly.
    $self->spec_hash('headers.customRequestHeaders')->{$key} = $value;
    return $self;
}

=method add_response_header

    $mw->add_response_header($key, $value);

Adds a header that Traefik will inject into every response as it returns
to the client. Writes the
C<spec.headers.customResponseHeaders.$key = $value> shape. If the same
C<$key> is added twice the last value wins. Returns C<$self> for chaining.

    $mw->add_response_header('X-Frame-Options', 'DENY');

=cut

sub add_response_header {
    my ($self, $key, $value) = @_;
    $self->spec_hash('headers.customResponseHeaders')->{$key} = $value;
    return $self;
}

1;

__END__

=head1 SYNOPSIS

    package My::TraefikMiddleware;
    use IO::K8s::APIObject
        api_version     => 'traefik.io/v1alpha1',
        resource_plural => 'middlewares';
    with 'IO::K8s::Role::MiddlewareBuilder';

    package main;
    my $k8s = IO::K8s->new(with => ['IO::K8s::Traefik']);
    my $mw = $k8s->new_object('Middleware',
        metadata => { name => 'api-limits', namespace => 'default' },
    );
    $mw->rate_limit(average => 100, burst => 200)
       ->strip_prefix('/api')
       ->redirect_https;

=head1 DESCRIPTION

This role provides the fluent Traefik middleware builders documented in
the README's Traefik section. Each method writes the corresponding block
under the C<spec> key Traefik's C<Middleware> CRD expects, so the chain
mirrors what a user would compose in YAML.

Each setter either replaces or extends its target block:

=over

=item * C<rate_limit>, C<basic_auth>, C<strip_prefix>, C<redirect_https>
overwrite the corresponding C<spec> key each time.

=item * C<add_request_header> / C<add_response_header> accumulate entries
under the same C<headers> parent block -- chained calls on the same parent
append rather than replace.

=back

Apply this role to any class whose C<spec> field is the Traefik
Middleware wire schema. The bundled Traefik CRD
L<IO::K8s::Traefik::V1alpha1::Middleware> is the obvious target, but the
role composes on custom CRD classes too.

=head1 SEE ALSO

L<IO::K8s::Traefik>, L<IO::K8s::Role::SpecBuilder>, L<IO::K8s::APIObject>

=cut