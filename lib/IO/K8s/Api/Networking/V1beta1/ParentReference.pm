package IO::K8s::Api::Networking::V1beta1::ParentReference;
# ABSTRACT: ParentReference describes a reference to a parent object.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s group => Str;

=attr group

Group is the group of the object being referenced.

=cut

k8s name => Str, 'required';

=attr name

Name is the name of the object being referenced.

=cut

k8s namespace => Str;

=attr namespace

Namespace is the namespace of the object being referenced.

=cut

k8s resource => Str, 'required';

=attr resource

Resource is the resource of the object being referenced.

=cut

1;
