package IO::K8s::Api::Admissionregistration::V1::Mutation;
# ABSTRACT: Mutation specifies the CEL expression which is used to apply the Mutation.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s applyConfiguration => 'Admissionregistration::V1::ApplyConfiguration';

=attr applyConfiguration

applyConfiguration defines the desired configuration values of an object. The configuration is applied to the admission object using L<structured merge diff|https://github.com/kubernetes-sigs/structured-merge-diff>. A CEL expression is used to create apply configuration.

=cut

k8s jsonPatch => 'Admissionregistration::V1::JSONPatch';

=attr jsonPatch

jsonPatch defines a L<JSON patch|https://jsonpatch.com/> operation to perform a mutation to the object. A CEL expression is used to create the JSON patch.

=cut

k8s patchType => Str, 'required';

=attr patchType

patchType indicates the patch strategy used. Allowed values are "ApplyConfiguration" and "JSONPatch".

Required.

=cut

1;
