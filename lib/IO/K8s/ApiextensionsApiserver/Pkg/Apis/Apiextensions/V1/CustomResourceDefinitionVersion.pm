package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinitionVersion;
# ABSTRACT: CustomResourceDefinitionVersion describes a version for CRD.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s additionalPrinterColumns => ['Apiextensions::V1::CustomResourceColumnDefinition'];

=attr additionalPrinterColumns

additionalPrinterColumns specifies additional columns returned in Table output. See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details. If no columns are specified, a single column displaying the age of the custom resource is used.

=cut

k8s deprecated => Bool;

=attr deprecated

deprecated indicates this version of the custom resource API is deprecated. When set to true, API requests to this version receive a warning header in the server response. Defaults to false.

=cut

k8s deprecationWarning => Str;

=attr deprecationWarning

deprecationWarning overrides the default warning returned to API clients. May only be set when `deprecated` is true. The default warning indicates this version is deprecated and recommends use of the newest served version of equal or greater stability, if one exists.

=cut

k8s name => Str, 'required';

=attr name

name is the version name, e.g. "v1", "v2beta1", etc. The custom resources are served under this version at `/apis/<group>/<version>/...` if `served` is true.

=cut

k8s schema => 'Apiextensions::V1::CustomResourceValidation';

=attr schema

schema describes the schema used for validation, pruning, and defaulting of this version of the custom resource.

=cut

k8s selectableFields => ['Apiextensions::V1::SelectableField'];

=attr selectableFields

selectableFields specifies paths to fields that may be used as field selectors. A maximum of 8 selectable fields are allowed. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors

=cut

k8s served => Bool, 'required';

=attr served

served is a flag enabling/disabling this version from being served via REST APIs

=cut

k8s storage => Bool, 'required';

=attr storage

storage indicates this version should be used when persisting custom resources to storage. There must be exactly one version with storage=true.

=cut

k8s subresources => 'Apiextensions::V1::CustomResourceSubresources';

=attr subresources

subresources specify what subresources this version of the defined custom resource have.

=cut

1;
