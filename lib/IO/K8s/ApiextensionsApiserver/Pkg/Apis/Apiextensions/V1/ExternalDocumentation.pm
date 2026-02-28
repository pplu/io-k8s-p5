package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::ExternalDocumentation;
# ABSTRACT: ExternalDocumentation allows referencing an external resource for extended documentation.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s description => Str;

k8s url => Str;

1;
