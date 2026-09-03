package IO::K8s::Cilium::V2alpha1::CiliumCIDRGroup;
# ABSTRACT: CiliumCIDRGroup is a list of external CIDRs (i.e: CIDRs selecting peers outside the clusters) that can be referenced as a single entity from CiliumNetworkPolicies.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumcidrgroups';

k8s spec => '+IO::K8s::Cilium::V2alpha1::CiliumCIDRGroupSpec', { required => 'schema' };

=attr spec

No description in the upstream schema.

=cut

1;
