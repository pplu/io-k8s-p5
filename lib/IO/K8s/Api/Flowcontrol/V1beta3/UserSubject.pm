package IO::K8s::Api::Flowcontrol::V1beta3::UserSubject;
# ABSTRACT: UserSubject holds detailed information for user-kind subject.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

C<name> is the username that matches, or "*" to match all usernames. Required.

=cut

1;
