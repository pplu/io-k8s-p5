package IO::K8s::Api::Authorization::V1::SubjectAccessReview;
# ABSTRACT: SubjectAccessReview checks whether or not a user or group can perform an action.

use IO::K8s::APIObject;

=head1 DESCRIPTION

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

1;
