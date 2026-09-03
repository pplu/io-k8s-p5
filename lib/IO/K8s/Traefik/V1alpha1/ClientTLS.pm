package IO::K8s::Traefik::V1alpha1::ClientTLS;
# ABSTRACT: TLS defines TLS-specific configurations, including the CA, certificate, and key, which can be provided as a file path or file content.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s caSecret           => Str;
k8s certSecret         => Str;
k8s insecureSkipVerify => Bool;

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
