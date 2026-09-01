package IO::K8s::Api::Lifecycle::V1alpha1::EvictionRequestPodReference;
# ABSTRACT: EvictionRequestPodReference contains enough information to locate the referenced pod inside the same namespace.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name of the target. This field is required.

=cut

k8s uid => Str, 'required';

=attr uid

uid of the target. It can be found in .metadata.uid of the target and is a lowercase UUID in 8-4-4-4-12 format. This field is required.

=cut

1;
