package IO::K8s::Api::Core::V1::TopologySelectorLabelRequirement;
# ABSTRACT: A topology selector requirement is a selector that matches given label. This is an alpha feature and may change in the future.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

The label key that the selector applies to.

=cut

k8s values => [Str], 'required';

=attr values

An array of string values. One value must match the label to be selected. Each entry in Values is ORed.

=cut

1;
