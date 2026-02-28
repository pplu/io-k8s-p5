package IO::K8s::Api::Core::V1::Binding;
# ABSTRACT: Binding ties one object to another; for example, a pod is bound to a node by a scheduler. Deprecated in 1.7, please use the bindings subresource of pods instead.
our $VERSION = '1.004';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Binding ties one object to another; for example, a pod is bound to a node by a scheduler. Deprecated in 1.7, please use the bindings subresource of pods instead.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s target => 'Core::V1::ObjectReference', 'required';

=attr target

The target object that you want to bind to the standard object.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#binding-v1-core>


=cut
1;
