package IO::K8s::Api::Rbac::V1::Subject;
# ABSTRACT: Subject contains a reference to the object or user identities a role binding applies to.  This can either hold a direct API object reference, or a value for non-objects such as user and group names.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s apiGroup => Str;

=attr apiGroup

APIGroup holds the API group of the referenced subject. Defaults to "" for ServiceAccount subjects. Defaults to "rbac.authorization.k8s.io" for User and Group subjects.

=cut

k8s kind => Str, 'required';

=attr kind

Kind of object being referenced. Values defined by this API group are "User", "Group", and "ServiceAccount". If the Authorizer does not recognized the kind value, the Authorizer should report an error.

=cut

k8s name => Str, 'required';

=attr name

Name of the object being referenced.

=cut

k8s namespace => Str;

=attr namespace

Namespace of the referenced object.  If the object kind is non-namespace, such as "User" or "Group", and this value is not empty the Authorizer should report an error.

=cut

1;
