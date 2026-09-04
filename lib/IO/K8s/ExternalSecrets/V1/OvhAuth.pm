package IO::K8s::ExternalSecrets::V1::OvhAuth;
# ABSTRACT: Authentication method (mtls or token).
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mtls  => '+IO::K8s::ExternalSecrets::V1::OvhClientMTLS';
k8s token => '+IO::K8s::ExternalSecrets::V1::OvhClientToken';

=attr mtls

OvhClientMTLS defines the configuration required to authenticate to OVHcloud's Secret Manager using mTLS.

=cut

=attr token

OvhClientToken defines the configuration required to authenticate to OVHcloud's Secret Manager using a token.

=cut

1;
