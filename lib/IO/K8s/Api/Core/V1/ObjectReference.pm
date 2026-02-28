package IO::K8s::Api::Core::V1::ObjectReference;
# ABSTRACT: ObjectReference contains enough information to let you inspect or modify the referred object.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

API version of the referent.

=cut

k8s fieldPath => Str;

=attr fieldPath

If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.

=cut

k8s kind => Str;

=attr kind

Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s name => Str;

=attr name

Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

k8s namespace => Str;

=attr namespace

Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

=cut

k8s resourceVersion => Str;

=attr resourceVersion

Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency

=cut

k8s uid => Str;

=attr uid

UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids

=cut

1;
