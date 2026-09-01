package IO::K8s::Api::Scheduling::V1alpha3::WorkloadPodGroupResourceClaim;
# ABSTRACT: WorkloadPodGroupResourceClaim references a dynamic resource claim that is shared across pods in the group.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name uniquely identifies this resource claim inside the group. This field is required. It must be a DNS_LABEL.

=cut

k8s resourceClaimName => Str;

=attr resourceClaimName

resourceClaimName is the name of a ResourceClaim object in the same namespace. This field is optional. If it is not specified, no resource claim is used. If set, it must be a DNS subdomain.

=cut

k8s resourceClaimTemplateName => Str;

=attr resourceClaimTemplateName

resourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace. This field is optional. If it is not specified, no resource claim template is used. If set, it must be a DNS subdomain.

=cut

1;
