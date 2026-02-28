package IO::K8s::Api::Apiserverinternal::V1alpha1::StorageVersion;
# ABSTRACT: Storage version of a specific resource.
our $VERSION = '1.006';
use IO::K8s::APIObject;

=description

Storage version of a specific resource.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Apiserverinternal::V1alpha1::StorageVersionSpec', 'required';

=attr spec

Spec is an empty spec. It is here to comply with Kubernetes API style.


=cut

k8s status => 'Apiserverinternal::V1alpha1::StorageVersionStatus', 'required';

=attr status

API server instances report the version they can decode and the version they encode objects to when persisting objects in the backend.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#storageversion-v1alpha1-apiserver.internal.k8s.io>


=cut
1;
