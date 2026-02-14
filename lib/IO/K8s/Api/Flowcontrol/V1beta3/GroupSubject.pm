package IO::K8s::Api::Flowcontrol::V1beta3::GroupSubject;
# ABSTRACT: GroupSubject holds detailed information for group-kind subject.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name is the user group that matches, or "*" to match all user groups. See https://github.com/kubernetes/apiserver/blob/master/pkg/authentication/user/user.go for some well-known group names. Required.

=cut

1;
