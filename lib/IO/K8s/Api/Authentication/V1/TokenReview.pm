package IO::K8s::Api::Authentication::V1::TokenReview;
# ABSTRACT: TokenReview attempts to authenticate a token to a known user. Note: TokenReview requests may be cached by the webhook token authenticator plugin in the kube-apiserver.
our $VERSION = '1.002';
use IO::K8s::APIObject;

=description

TokenReview attempts to authenticate a token to a known user. Note: TokenReview requests may be cached by the webhook token authenticator plugin in the kube-apiserver.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Authentication::V1::TokenReviewSpec', 'required';

=attr spec

Spec holds information about the request being evaluated


=cut

k8s status => 'Authentication::V1::TokenReviewStatus';

=attr status

Status is filled in by the server and indicates whether the request can be authenticated.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#tokenreview-v1-authentication.k8s.io>


=cut
1;
