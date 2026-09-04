package IO::K8s::ExternalSecrets::V1::PassboltProvider;
# ABSTRACT: PassboltProvider provides access to Passbolt secrets manager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::PassboltAuth', { required => 'schema' };
k8s caBundle   => Str;
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s host       => Str, { required => 'schema' };

=attr auth

Auth defines the information necessary to authenticate against Passbolt Server

=cut

=attr caBundle

PEM encoded CA bundle used to validate Passbolt server certificate. Only used
if the Host URL is using HTTPS protocol. If not set the system root certificates
are used to validate the TLS connection.

=cut

=attr caProvider

The provider for the CA bundle to use to validate Passbolt server certificate.

=cut

=attr host

Host defines the Passbolt Server to connect to

=cut

1;
