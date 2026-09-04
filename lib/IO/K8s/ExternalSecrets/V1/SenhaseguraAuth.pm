package IO::K8s::ExternalSecrets::V1::SenhaseguraAuth;
# ABSTRACT: Auth defines parameters to authenticate in senhasegura
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId              => Str, { required => 'schema' };
k8s clientSecretSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr clientId

No description in the upstream schema.

=cut

=attr clientSecretSecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
