package IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerProvider;
# ABSTRACT: BitwardenSecretsManager configures this store to sync secrets using BitwardenSecretsManager provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiURL                => Str;
k8s auth                  => '+IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerAuth', { required => 'schema' };
k8s bitwardenServerSDKURL => Str;
k8s caBundle              => Str;
k8s caProvider            => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s identityURL           => Str;
k8s organizationID        => Str, { required => 'schema' };
k8s projectID             => Str, { required => 'schema' };

=attr apiURL

No description in the upstream schema.

=cut

=attr auth

Auth configures how secret-manager authenticates with a bitwarden machine account instance.
Make sure that the token being used has permissions on the given secret.

=cut

=attr bitwardenServerSDKURL

No description in the upstream schema.

=cut

=attr caBundle

Base64 encoded certificate for the bitwarden server sdk. The sdk MUST run with HTTPS to make sure no MITM attack
can be performed.

=cut

=attr caProvider

see: https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider

=cut

=attr identityURL

No description in the upstream schema.

=cut

=attr organizationID

OrganizationID determines which organization this secret store manages.

=cut

=attr projectID

ProjectID determines which project this secret store manages.

=cut

1;
