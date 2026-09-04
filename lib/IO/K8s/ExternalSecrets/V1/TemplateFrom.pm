package IO::K8s::ExternalSecrets::V1::TemplateFrom;
# ABSTRACT: TemplateFrom specifies a source for templates.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s configMap              => '+IO::K8s::ExternalSecrets::V1::TemplateRef';
k8s literal                => Str;
k8s secret                 => '+IO::K8s::ExternalSecrets::V1::TemplateRef';
k8s target                 => Str, { default => 'Data' };
k8s valuesDecodingStrategy => Str, { enum => [qw(Auto Base64 Base64URL None)] };

=attr configMap

TemplateRef specifies a reference to either a ConfigMap or a Secret resource.

=cut

=attr literal

No description in the upstream schema.

=cut

=attr secret

TemplateRef specifies a reference to either a ConfigMap or a Secret resource.

=cut

=attr target

Target specifies where to place the template result.
For Secret resources the accepted values are empty, "Data", "Annotations" and "Labels";
any other value is rejected because it would allow writes to privileged Secret fields.
For custom resources (when spec.target.manifest is set), this supports
nested paths like "spec.database.config" or "data".

=cut

=attr valuesDecodingStrategy

Used to define a decoding Strategy for the rendered template values.
Defaults to None when omitted.

=cut

1;
