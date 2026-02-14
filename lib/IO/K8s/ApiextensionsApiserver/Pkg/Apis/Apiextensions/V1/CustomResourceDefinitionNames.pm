package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinitionNames;
# ABSTRACT: CustomResourceDefinitionNames indicates the names to serve this CustomResourceDefinition
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s categories => [Str];

=attr categories

categories is a list of grouped resources this custom resource belongs to (e.g. 'all'). This is published in API discovery documents, and used by clients to support invocations like `kubectl get all`.

=cut

k8s kind => Str, 'required';

=attr kind

kind is the serialized kind of the resource. It is normally CamelCase and singular. Custom resource instances will use this value as the `kind` attribute in API calls.

=cut

k8s listKind => Str;

=attr listKind

listKind is the serialized kind of the list for this resource. Defaults to "`kind`List".

=cut

k8s plural => Str, 'required';

=attr plural

plural is the plural name of the resource to serve. The custom resources are served under `/apis/<group>/<version>/.../<plural>`. Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`). Must be all lowercase.

=cut

k8s shortNames => [Str];

=attr shortNames

shortNames are short names for the resource, exposed in API discovery documents, and used by clients to support invocations like `kubectl get <shortname>`. It must be all lowercase.

=cut

k8s singular => Str;

=attr singular

singular is the singular name of the resource. It must be all lowercase. Defaults to lowercased `kind`.

=cut

1;
