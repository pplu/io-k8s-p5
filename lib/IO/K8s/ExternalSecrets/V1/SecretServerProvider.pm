package IO::K8s::ExternalSecrets::V1::SecretServerProvider;
# ABSTRACT: SecretServer configures this store to sync secrets using SecretServer provider https://docs.delinea.com/online-help/secret-server/start.htm
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caBundle                => Str;
k8s caProvider              => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s disableSiteIDValidation => Bool;
k8s domain                  => Str;
k8s password                => '+IO::K8s::ExternalSecrets::V1::SecretServerProviderRef';
k8s serverURL               => Str, { required => 'schema' };
k8s siteId                  => Int, { minimum => 1 };
k8s token                   => '+IO::K8s::ExternalSecrets::V1::SecretServerProviderRef';
k8s username                => '+IO::K8s::ExternalSecrets::V1::SecretServerProviderRef';

=attr caBundle

PEM/base64 encoded CA bundle used to validate Secret ServerURL. Only used
if the ServerURL URL is using HTTPS protocol. If not set the system root certificates
are used to validate the TLS connection.

=cut

=attr caProvider

The provider for the CA bundle to use to validate Secret ServerURL certificate.

=cut

=attr disableSiteIDValidation

DisableSiteIDValidation permits a missing site ID for new secrets.
The provider sends 0 if no site ID is set.

=cut

=attr domain

Domain is the secret server domain.

=cut

=attr password

Password is the secret server account password.
Required unless Token is set.

=cut

=attr serverURL

ServerURL
URL to your secret server installation

=cut

=attr siteId

SiteID is the ID of the Secret Server site for new secrets.
PushSecret metadata can override this value for one secret.
The provider uses 1 if this field is not set.

=cut

=attr token

Token is an access token used to authenticate to the secret server,
as an alternative to Username and Password. When set, Username and
Password are not required and are ignored.

=cut

=attr username

Username is the secret server account username.
Required unless Token is set.

=cut

1;
