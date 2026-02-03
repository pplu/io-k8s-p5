package IO::K8s::Api::Autoscaling::V1::CrossVersionObjectReference;
# ABSTRACT: CrossVersionObjectReference contains enough information to let you identify the referred resource.

use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

apiVersion is the API version of the referent

=cut

k8s kind => Str, 'required';

=attr kind

kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s name => Str, 'required';

=attr name

name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

1;
