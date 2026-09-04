package IO::K8s::Role::Loadbalanced;
# ABSTRACT: Role for traffic distribution (weighted backends, mirroring)
our $VERSION = '1.108';
use Moo::Role;

# The fluent setters below build the spec through IO::K8s::Role::SpecBuilder
# rather than by hand, so that role is a hard dependency of this one (k103).
# IO::K8s::Role::APIObject composes SpecBuilder for every top-level Kind, so
# these are satisfied for anything built with IO::K8s::APIObject; a class
# that composes this role without them now fails at composition time,
# naming the missing method, instead of at the first setter call.
requires qw( spec_array spec_get spec_push spec_set );

=method set_weighted

    $obj->set_weighted($name, $weight);

Upserts a weighted backend into C<spec.weighted.services>. If a backend with
C<name =E<gt> $name> already exists its weight is replaced; otherwise the
C<< { name =E<gt> $name, weight =E<gt> $weight } >> entry is appended. The
shape matches Istio's DestinationRule C<trafficPolicy> weighted subset
semantics -- useful when a CRD consumer wants the same UX across several
traffic-management kinds. Returns C<$self> for chaining.

    $route->set_weighted('api-v1', 90)->set_weighted('api-v2', 10);

=cut

sub set_weighted {
    my ($self, $name, $weight) = @_;
    my $services = $self->spec_array('weighted.services');
    for my $i (0 .. $#$services) {
        next unless ($self->spec_get("weighted.services.$i.name") // '') eq $name;
        $self->spec_set("weighted.services.$i.weight", $weight);
        return $self;
    }
    $self->spec_push('weighted.services', { name => $name, weight => $weight });
    return $self;
}

=method mirror_to

    $obj->mirror_to($name, percent => $percent);

Appends a mirror entry under C<spec.mirroring.mirrors> that sends a
percentage of traffic (C<percent>, 1-100) to the named backend. C<percent>
is optional -- when omitted the entry has no C<percent> field and the
consumer decides the default. Mirroring entries are appended; the method
does not de-duplicate. Returns C<$self> for chaining.

    $route->mirror_to('shadow', percent => 5);

=cut

sub mirror_to {
    my ($self, $name, %opts) = @_;
    $self->spec_push('mirroring.mirrors', {
        name => $name,
        $opts{percent} ? (percent => $opts{percent}) : (),
    });
    return $self;
}

1;

__END__

=head1 SYNOPSIS

    package My::Route;
    use IO::K8s::APIObject api_version => 'example.com/v1';
    with 'IO::K8s::Role::Loadbalanced';

    package main;
    my $r = My::Route->new;
    $r->set_weighted('canary', 10)->set_weighted('stable', 90)
      ->mirror_to('shadow', percent => 1);

=head1 DESCRIPTION

This role provides the two traffic-distribution operations documented in
the README's fluent-API section: weighted backend fan-out and traffic
mirroring. Both write through L<IO::K8s::Role::SpecBuilder>'s C<spec_*>
methods, so the role composes cleanly with CRD classes whose C<spec> is
either a hash or a typed object.

Apply this role to a custom CRD class that exposes the same
C<weighted.services> / C<mirroring.mirrors> shape on the wire. The
Istio DestinationRule CRD and the Gateway API TCPRoute spec both fit this
shape without changes; arbitrary CRDs may need their own adaptation.

=head1 SEE ALSO

L<IO::K8s::Role::Routable>, L<IO::K8s::Role::SpecBuilder>,
L<IO::K8s::APIObject>

=cut