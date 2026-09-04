package IO::K8s::ExternalSecrets::V1::ExternalSecretTemplate;
# ABSTRACT: Template defines a blueprint for the created Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s data          => { Str => 1 };
k8s engineVersion => Str, { enum => [qw(v2)], default => 'v2' };
k8s mergePolicy   => Str, { enum => [qw(Replace Merge)], default => 'Replace' };
k8s metadata      => '+IO::K8s::ExternalSecrets::V1::ExternalSecretTemplateMetadata';
k8s templateFrom  => ['+IO::K8s::ExternalSecrets::V1::TemplateFrom'];
k8s type          => Str;

=attr data

No description in the upstream schema.

=cut

=attr engineVersion

EngineVersion specifies the template engine version
that should be used to compile/execute the
template specified in .data and .templateFrom[].

=cut

=attr mergePolicy

TemplateMergePolicy defines how the rendered template should be merged with the existing Secret data.

=cut

=attr metadata

ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.

=cut

=attr templateFrom

No description in the upstream schema.

=cut

=attr type

No description in the upstream schema.

=cut

1;
