package IO::K8s::Cilium::V2::CiliumExternalWorkload;
# ABSTRACT: Cilium external workload identity
our $VERSION = '1.002';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumexternalworkloads';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource registers an external (non-Kubernetes) workload with the Cilium cluster mesh, allowing VMs or bare-metal servers to participate in Cilium's network security and service mesh. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium cluster mesh controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/external-workloads/> - Upstream Cilium external workloads documentation

=back

=cut
