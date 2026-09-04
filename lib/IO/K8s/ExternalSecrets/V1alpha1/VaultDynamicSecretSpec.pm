package IO::K8s::ExternalSecrets::V1alpha1::VaultDynamicSecretSpec;
# ABSTRACT: VaultDynamicSecretSpec defines the desired spec of VaultDynamicSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowEmptyResponse => Bool, { default => 0 };
k8s controller         => Str;
k8s getParameters      => { Str => 1 };
k8s method             => Str;
k8s parameters         => Str, { preserve_unknown => 1 };
k8s path               => Str, { required => 'schema' };
k8s provider           => '+IO::K8s::ExternalSecrets::V1::VaultProvider', { required => 'schema' };
k8s resultType         => Str, { enum => [qw(Data Auth Raw)], default => 'Data' };
k8s retrySettings      => '+IO::K8s::ExternalSecrets::V1::SecretStoreRetrySettings';

=attr allowEmptyResponse

Do not fail if no secrets are found. Useful for requests where no data is expected.

=cut

=attr controller

Used to select the correct ESO controller (think: ingress.ingressClassName)
The ESO controller is instantiated with a specific controller name and filters VDS based on this property

=cut

=attr getParameters

GetParameters are query-string parameters passed to Vault on GET calls.
Each key may map to multiple values, matching HTTP query-string semantics.
Ignored for non-GET methods; use Parameters for write bodies.

=cut

=attr method

Vault API method to use (GET/POST/other)

=cut

=attr parameters

Parameters to pass to Vault write (for non-GET methods)

=cut

=attr path

Vault path to obtain the dynamic secret from

=cut

=attr provider

Vault provider common spec

=cut

=attr resultType

Result type defines which data is returned from the generator.
By default, it is the "data" section of the Vault API response.
When using e.g. /auth/token/create the "data" section is empty but
the "auth" section contains the generated token.
Please refer to the vault docs regarding the result data structure.
Additionally, accessing the raw response is possibly by using "Raw" result type.

=cut

=attr retrySettings

Used to configure http retries if failed

=cut

1;
