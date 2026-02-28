package IO::K8s::Api::Flowcontrol::V1::Subject;
# ABSTRACT: Subject matches the originator of a request, as identified by the request authentication system. There are three ways of matching an originator; by user, group, or service account.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s group => 'Flowcontrol::V1::GroupSubject';

=attr group

`group` matches based on user group name.

=cut

k8s kind => Str, 'required';

=attr kind

`kind` indicates which one of the other fields is non-empty. Required

=cut

k8s serviceAccount => 'Flowcontrol::V1::ServiceAccountSubject';

=attr serviceAccount

`serviceAccount` matches ServiceAccounts.

=cut

k8s user => 'Flowcontrol::V1::UserSubject';

=attr user

`user` matches based on username.

=cut

1;
