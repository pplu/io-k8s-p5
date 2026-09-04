package IO::K8s::ExternalSecrets::V1::InfisicalProvider;
# ABSTRACT: Infisical configures this store to sync secrets using the Infisical provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth         => '+IO::K8s::ExternalSecrets::V1::InfisicalAuth', { required => 'schema' };
k8s caBundle     => Str;
k8s caProvider   => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s hostAPI      => Str, { default => 'https://app.infisical.com/api' };
k8s secretsScope => '+IO::K8s::ExternalSecrets::V1::MachineIdentityScopeInWorkspace', { required => 'schema' };

=attr auth

Auth configures how the Operator authenticates with the Infisical API

=cut

=attr caBundle

CABundle is a PEM-encoded CA certificate bundle used to validate
the Infisical server's TLS certificate. Mutually exclusive with CAProvider.

=cut

=attr caProvider

CAProvider is a reference to a Secret or ConfigMap that contains a CA certificate.
The certificate is used to validate the Infisical server's TLS certificate.
Mutually exclusive with CABundle.

=cut

=attr hostAPI

HostAPI specifies the base URL of the Infisical API. If not provided, it defaults to "https://app.infisical.com/api".

=cut

=attr secretsScope

SecretsScope defines the scope of the secrets within the workspace

=cut

1;
