package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::SelectableField;
# ABSTRACT: SelectableField specifies the JSON path of a field that may be used with field selectors.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s jsonPath => Str, 'required';

=attr jsonPath

jsonPath is a simple JSON path which is evaluated against each custom resource to produce a field selector value. Only JSON paths without the array notation are allowed. Must point to a field of type string, boolean or integer. Types with enum values and strings with formats are allowed. If jsonPath refers to absent field in a resource, the jsonPath evaluates to an empty string. Must not point to metdata fields. Required.

=cut

1;
