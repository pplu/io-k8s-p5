package IO::K8s::Cilium::V2::CiliumCIDRGroupSpec;
# ABSTRACT: CiliumCIDRGroupSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s externalCIDRs => [Str], { required => 'schema' };

=attr externalCIDRs

ExternalCIDRs is a list of CIDRs selecting peers outside the clusters.

=cut

1;
