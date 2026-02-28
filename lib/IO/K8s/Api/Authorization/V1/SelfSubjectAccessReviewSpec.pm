package IO::K8s::Api::Authorization::V1::SelfSubjectAccessReviewSpec;
# ABSTRACT: SelfSubjectAccessReviewSpec is a description of the access request.  Exactly one of ResourceAuthorizationAttributes and NonResourceAuthorizationAttributes must be set
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s nonResourceAttributes => 'Authorization::V1::NonResourceAttributes';

=attr nonResourceAttributes

NonResourceAttributes describes information for a non-resource access request

=cut

k8s resourceAttributes => 'Authorization::V1::ResourceAttributes';

=attr resourceAttributes

ResourceAuthorizationAttributes describes information for a resource access request

=cut

1;
