package IO::K8s::Api::Resource::V1alpha3::DeviceClass;
# ABSTRACT: DeviceClass is a vendor- or admin-provided resource that contains device configuration and selectors. It can be referenced in the device requests of a claim to apply these presets. Cluster scoped. This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
our $VERSION = '1.007';
use IO::K8s::APIObject;

=description

DeviceClass is a vendor- or admin-provided resource that contains device configuration and selectors. It can be referenced in the device requests of a claim to apply these presets. Cluster scoped. This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1alpha3::DeviceClassSpec', 'required';

=attr spec

Spec defines what can be allocated and how to configure it.

This is mutable. Consumers have to be prepared for classes changing at any time, either because they get updated or replaced. Claim allocations are done once based on whatever was set in classes at the time of allocation.

Changing the spec automatically increments the metadata.generation number.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#deviceclass-v1alpha3-resource.k8s.io>


=cut
1;
