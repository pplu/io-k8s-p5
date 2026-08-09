package IO::K8s::Api::Resource::V1alpha3::DeviceTaintRule;
# ABSTRACT: DeviceTaintRule adds one taint to all devices which match the selector. This has the same effect as if the taint was specified directly in the ResourceSlice by the DRA driver.
our $VERSION = '1.106';
use IO::K8s::APIObject;

=description

DeviceTaintRule adds one taint to all devices which match the selector. This has the same effect as if the taint was specified directly in the ResourceSlice by the DRA driver.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1alpha3::DeviceTaintRuleSpec', 'required';

=attr spec

Spec specifies the selector and one taint.  Changing the spec automatically increments the metadata.generation number.

=cut

k8s status => 'Resource::V1alpha3::DeviceTaintRuleStatus';

=attr status

Status provides information about what was requested in the spec.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#devicetaintrule-v1alpha3-resource.k8s.io>


=cut
1;
