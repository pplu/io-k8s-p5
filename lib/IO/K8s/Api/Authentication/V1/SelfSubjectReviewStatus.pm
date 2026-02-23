package IO::K8s::Api::Authentication::V1::SelfSubjectReviewStatus;
# ABSTRACT: SelfSubjectReviewStatus is filled by the kube-apiserver and sent back to a user.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s userInfo => 'Authentication::V1::UserInfo';

=attr userInfo

User attributes of the user making this request.

=cut

1;
