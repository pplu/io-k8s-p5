package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceValidation;
# ABSTRACT: CustomResourceValidation is a list of validation methods for CustomResources.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s openAPIV3Schema => 'Apiextensions::V1::JSONSchemaProps';

=attr openAPIV3Schema

openAPIV3Schema is the OpenAPI v3 schema to use for validation and pruning.

=cut

1;
