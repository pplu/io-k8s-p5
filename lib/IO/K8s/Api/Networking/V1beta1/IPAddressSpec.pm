package IO::K8s::Api::Networking::V1beta1::IPAddressSpec;
# ABSTRACT: IPAddressSpec describe the attributes in an IP Address.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s parentRef => 'Networking::V1beta1::ParentReference', 'required';

=attr parentRef

ParentRef references the resource that an IPAddress is attached to. An IPAddress must reference a parent object.

=cut

1;
