package IO::K8s::Api::Core::V1::ResourceStatus;
# ABSTRACT: 
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name of the resource. Must be unique within the pod and match one of the resources from the pod spec.

=cut

k8s resources => ['Core::V1::ResourceHealth'];

=attr resources

List of unique Resources health. Each element in the list contains an unique resource ID and resource health. At a minimum, ResourceID must uniquely identify the Resource allocated to the Pod on the Node for the lifetime of a Pod. See ResourceID type for it's definition.

=cut

1;
