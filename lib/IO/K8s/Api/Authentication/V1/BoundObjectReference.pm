package IO::K8s::Api::Authentication::V1::BoundObjectReference;
# ABSTRACT: BoundObjectReference is a reference to an object that a token is bound to.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

API version of the referent.

=cut

k8s kind => Str;

=attr kind

Kind of the referent. Valid kinds are 'Pod' and 'Secret'.

=cut

k8s name => Str;

=attr name

Name of the referent.

=cut

k8s uid => Str;

=attr uid

UID of the referent.

=cut

1;
