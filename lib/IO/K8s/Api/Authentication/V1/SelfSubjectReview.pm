package IO::K8s::Api::Authentication::V1::SelfSubjectReview;
# ABSTRACT: SelfSubjectReview contains the user information that the kube-apiserver has about the user making this request. When using impersonation, users will receive the user info of the user being impersonated.  If impersonation or request header authentication is used, any extra keys will have their case ignored and returned as lowercase.
our $VERSION = '1.001';
use IO::K8s::APIObject;

=description

SelfSubjectReview contains the user information that the kube-apiserver has about the user making this request. When using impersonation, users will receive the user info of the user being impersonated.  If impersonation or request header authentication is used, any extra keys will have their case ignored and returned as lowercase.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s status => 'Authentication::V1::SelfSubjectReviewStatus';

=attr status

Status is filled in by the server with the user attributes.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#selfsubjectreview-v1-authentication.k8s.io>


=cut
1;
