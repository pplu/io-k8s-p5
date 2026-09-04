package IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteTransform;
# ABSTRACT: Used to apply string transformation on the secrets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s template => Str, { required => 'schema' };

=attr template

Used to define the template to apply on the secret name.
`.value ` will specify the secret name in the template.

=cut

1;
