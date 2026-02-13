package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceColumnDefinition;
# ABSTRACT: CustomResourceColumnDefinition specifies a column for server side printing.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s description => Str;

=attr description

description is a human readable description of this column.

=cut

k8s format => Str;

=attr format

format is an optional OpenAPI type definition for this column. The 'name' format is applied to the primary identifier column to assist in clients identifying column is the resource name. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.

=cut

k8s jsonPath => Str, 'required';

=attr jsonPath

jsonPath is a simple JSON path (i.e. with array notation) which is evaluated against each custom resource to produce the value for this column.

=cut

k8s name => Str, 'required';

=attr name

name is a human readable name for the column.

=cut

k8s priority => Int;

=attr priority

priority is an integer defining the relative importance of this column compared to others. Lower numbers are considered higher priority. Columns that may be omitted in limited space scenarios should be given a priority greater than 0.

=cut

k8s type => Str, 'required';

=attr type

type is an OpenAPI type definition for this column. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.

=cut

1;
