package IO::K8s::Traefik::V1alpha1::ClientTLSWithCAOptional;
# ABSTRACT: TLS defines the configuration used to secure the connection to the authentication server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caOptional         => Bool;
k8s caSecret           => Str;
k8s certSecret         => Str;
k8s insecureSkipVerify => Bool;

=attr caOptional

Deprecated: TLS client authentication is a server side option (see https://github.com/golang/go/blob/740a490f71d026bb7d2d13cb8fa2d6d6e0572b70/src/crypto/tls/common.go#L634).

=cut

=attr caSecret

CASecret is the name of the referenced Kubernetes Secret containing the CA to validate the server certificate.
The CA certificate is extracted from key `tls.ca` or `ca.crt`.

=cut

=attr certSecret

CertSecret is the name of the referenced Kubernetes Secret containing the client certificate.
The client certificate is extracted from the keys `tls.crt` and `tls.key`.

=cut

=attr insecureSkipVerify

InsecureSkipVerify defines whether the server certificates should be validated.

=cut

1;
