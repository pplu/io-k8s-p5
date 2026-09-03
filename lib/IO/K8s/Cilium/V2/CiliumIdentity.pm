package IO::K8s::Cilium::V2::CiliumIdentity;
# ABSTRACT: CiliumIdentity is a CRD that represents an identity managed by Cilium.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumidentities';

k8s 'security-labels' => { Str => 1 }, { required => 'schema' };

=attr security-labels

SecurityLabels is the source-of-truth set of labels for this identity.

=cut

1;
