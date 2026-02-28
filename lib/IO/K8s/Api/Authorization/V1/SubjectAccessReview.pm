package IO::K8s::Api::Authorization::V1::SubjectAccessReview;
# ABSTRACT: SubjectAccessReview checks whether or not a user or group can perform an action.
our $VERSION = '1.005';
use IO::K8s::APIObject;

=description

SubjectAccessReview checks whether or not a user or group can perform an action.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Authorization::V1::SubjectAccessReviewSpec', 'required';

=attr spec

Spec holds information about the request being evaluated


=cut

k8s status => 'Authorization::V1::SubjectAccessReviewStatus';

=attr status

Status is filled in by the server and indicates whether the request is allowed or not


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#subjectaccessreview-v1-authorization.k8s.io>


=cut
1;
