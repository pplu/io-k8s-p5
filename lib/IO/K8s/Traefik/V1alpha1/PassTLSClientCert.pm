package IO::K8s::Traefik::V1alpha1::PassTLSClientCert;
# ABSTRACT: PassTLSClientCert holds the pass TLS client cert middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s info => '+IO::K8s::Traefik::V1alpha1::TLSClientCertificateInfo';
k8s pem  => Bool;

=attr info

Info selects the specific client certificate details you want to add to the X-Forwarded-Tls-Client-Cert-Info header.

=cut

=attr pem

PEM sets the X-Forwarded-Tls-Client-Cert header with the certificate.

=cut

1;
