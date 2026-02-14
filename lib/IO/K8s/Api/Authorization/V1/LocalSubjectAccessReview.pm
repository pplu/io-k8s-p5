package IO::K8s::Api::Authorization::V1::LocalSubjectAccessReview;
# ABSTRACT: LocalSubjectAccessReview checks whether or not a user or group can perform an action in a given namespace. Having a namespace scoped resource makes it much easier to grant namespace scoped policy that includes permissions checking.
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

LocalSubjectAccessReview checks whether or not a user or group can perform an action in a given namespace. Having a namespace scoped resource makes it much easier to grant namespace scoped policy that includes permissions checking.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Authorization::V1::SubjectAccessReviewSpec', 'required';

=attr spec

Spec holds information about the request being evaluated.  spec.namespace must be equal to the namespace you made the request against.  If empty, it is defaulted.


=cut

k8s status => 'Authorization::V1::SubjectAccessReviewStatus';

=attr status

Status is filled in by the server and indicates whether the request is allowed or not


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#localsubjectaccessreview-v1-authorization.k8s.io>


=cut
1;
