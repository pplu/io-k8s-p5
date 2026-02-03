package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinitionSpec;
# ABSTRACT: CustomResourceDefinitionSpec describes how a user wants their resource to appear

use IO::K8s::Resource;

k8s conversion => 'Apiextensions::V1::CustomResourceConversion';

=attr conversion

conversion defines conversion settings for the CRD.

=cut

k8s group => Str, 'required';

=attr group

group is the API group of the defined custom resource. The custom resources are served under `/apis/<group>/...`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).

=cut

k8s names => 'Apiextensions::V1::CustomResourceDefinitionNames', 'required';

=attr names

names specify the resource and kind names for the custom resource.

=cut

k8s preserveUnknownFields => Bool;

=attr preserveUnknownFields

preserveUnknownFields indicates that object fields which are not specified in the OpenAPI schema should be preserved when persisting to storage. apiVersion, kind, metadata and known fields inside metadata are always preserved. This field is deprecated in favor of setting `x-preserve-unknown-fields` to true in `spec.versions[*].schema.openAPIV3Schema`. See https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#field-pruning for details.

=cut

k8s scope => Str, 'required';

=attr scope

scope indicates whether the defined custom resource is cluster- or namespace-scoped. Allowed values are `Cluster` and `Namespaced`.

=cut

k8s versions => ['Apiextensions::V1::CustomResourceDefinitionVersion'], 'required';

=attr versions

versions is the list of all API versions of the defined custom resource. Version names are used to compute the order in which served versions are listed in API discovery. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.

=cut

1;
