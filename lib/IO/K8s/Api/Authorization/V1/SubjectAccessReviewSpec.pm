package IO::K8s::Api::Authorization::V1::SubjectAccessReviewSpec;
# ABSTRACT: SubjectAccessReviewSpec is a description of the access request.  Exactly one of ResourceAuthorizationAttributes and NonResourceAuthorizationAttributes must be set
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s extra => { Str => 1 };

=attr extra

Extra corresponds to the user.Info.GetExtra() method from the authenticator.  Since that is input to the authorizer it needs a reflection here.

=cut

k8s groups => [Str];

=attr groups

Groups is the groups you're testing for.

=cut

k8s nonResourceAttributes => 'Authorization::V1::NonResourceAttributes';

=attr nonResourceAttributes

NonResourceAttributes describes information for a non-resource access request

=cut

k8s resourceAttributes => 'Authorization::V1::ResourceAttributes';

=attr resourceAttributes

ResourceAuthorizationAttributes describes information for a resource access request

=cut

k8s uid => Str;

=attr uid

UID information about the requesting user.

=cut

k8s user => Str;

=attr user

User is the user you're testing for. If you specify "User" but not "Groups", then is it interpreted as "What if User were not a member of any groups

=cut

1;
