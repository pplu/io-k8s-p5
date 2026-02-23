package IO::K8s::K3s::V1::Addon;
# ABSTRACT: K3s cluster addon
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'k3s.cattle.io/v1',
    resource_plural => 'addons';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This class represents an Addon custom resource in the C<k3s.cattle.io/v1> API group. Addon resources represent K3s cluster addons, which are Kubernetes manifests automatically deployed during cluster startup or runtime. This is a namespace-scoped resource where the C<spec> and C<status> fields are opaque hash structures defined by the K3s API.

=seealso

=over

=item * L<IO::K8s::K3s> - K3s custom resources

=item * L<https://docs.k3s.io/installation/packaged-components> - K3s Packaged Components Documentation

=back

=cut
