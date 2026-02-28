package IO::K8s::Api::Authentication::V1::UserInfo;
# ABSTRACT: UserInfo holds the information about the user needed to implement the user.Info interface.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s extra => { Str => 1 };

=attr extra

Any additional information provided by the authenticator.

=cut

k8s groups => [Str];

=attr groups

The names of groups this user is a part of.

=cut

k8s uid => Str;

=attr uid

A unique value that identifies this user across time. If this user is deleted and another user by the same name is added, they will have different UIDs.

=cut

k8s username => Str;

=attr username

The name that uniquely identifies this user among all active users.

=cut

1;
