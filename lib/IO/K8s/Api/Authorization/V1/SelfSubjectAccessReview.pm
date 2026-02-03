package IO::K8s::Api::Authorization::V1::SelfSubjectAccessReview;
# ABSTRACT: SelfSubjectAccessReview checks whether or the current user can perform an action.  Not filling in a spec.namespace means "in all namespaces".  Self is a special case, because users should always be able to check whether they can perform an action

use IO::K8s::APIObject;

=head1 DESCRIPTION

SelfSubjectAccessReview checks whether or the current user can perform an action.  Not filling in a spec.namespace means "in all namespaces".  Self is a special case, because users should always be able to check whether they can perform an action

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Authorization::V1::SelfSubjectAccessReviewSpec', 'required';

=attr spec

Spec holds information about the request being evaluated.  user and groups must be empty

=cut

k8s status => 'Authorization::V1::SubjectAccessReviewStatus';

=attr status

Status is filled in by the server and indicates whether the request is allowed or not

=cut

1;
