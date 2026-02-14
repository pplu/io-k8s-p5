package IO::K8s::Api::Core::V1::ResourceClaim;
# ABSTRACT: ResourceClaim references one entry in PodSpec.ResourceClaims.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.

=cut

k8s request => Str;

=attr request

Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request.

=cut

1;
