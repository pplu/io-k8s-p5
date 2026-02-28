package IO::K8s::Api::Rbac::V1::RoleRef;
# ABSTRACT: RoleRef contains information that points to the role being used
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s apiGroup => Str, 'required';

=attr apiGroup

APIGroup is the group for the resource being referenced

=cut

k8s kind => Str, 'required';

=attr kind

Kind is the type of resource being referenced

=cut

k8s name => Str, 'required';

=attr name

Name is the name of resource being referenced

=cut

1;
