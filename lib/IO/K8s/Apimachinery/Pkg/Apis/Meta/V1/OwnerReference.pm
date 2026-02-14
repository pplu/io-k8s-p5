package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::OwnerReference;
# ABSTRACT: OwnerReference contains enough information to let you identify an owning object. An owning object must be in the same namespace as the dependent, or be cluster-scoped, so there is no namespace field.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s apiVersion => Str, 'required';

=attr apiVersion

API version of the referent.

=cut

k8s blockOwnerDeletion => Bool;

=attr blockOwnerDeletion

If true, AND if the owner has the "foregroundDeletion" finalizer, then the owner cannot be deleted from the key-value store until this reference is removed. See https://kubernetes.io/docs/concepts/architecture/garbage-collection/#foreground-deletion for how the garbage collector interacts with this field and enforces the foreground deletion. Defaults to false. To set this field, a user needs "delete" permission of the owner, otherwise 422 (Unprocessable Entity) will be returned.

=cut

k8s controller => Bool;

=attr controller

If true, this reference points to the managing controller.

=cut

k8s kind => Str, 'required';

=attr kind

Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s name => Str, 'required';

=attr name

Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names

=cut

k8s uid => Str, 'required';

=attr uid

UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#uids

=cut

1;
