package IO::K8s::Traefik::V1alpha1::TLSClientCertificateInfo;
# ABSTRACT: Info selects the specific client certificate details you want to add to the X-Forwarded-Tls-Client-Cert-Info header.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s issuer       => '+IO::K8s::Traefik::V1alpha1::TLSClientCertificateIssuerDNInfo';
k8s notAfter     => Bool;
k8s notBefore    => Bool;
k8s sans         => Bool;
k8s serialNumber => Bool;
k8s subject      => '+IO::K8s::Traefik::V1alpha1::TLSClientCertificateSubjectDNInfo';

=attr issuer

Issuer defines the client certificate issuer details to add to the X-Forwarded-Tls-Client-Cert-Info header.

=cut

=attr notAfter

NotAfter defines whether to add the Not After information from the Validity part.

=cut

=attr notBefore

NotBefore defines whether to add the Not Before information from the Validity part.

=cut

=attr sans

Sans defines whether to add the Subject Alternative Name information from the Subject Alternative Name part.

=cut

=attr serialNumber

SerialNumber defines whether to add the client serialNumber information.

=cut

=attr subject

Subject defines the client certificate subject details to add to the X-Forwarded-Tls-Client-Cert-Info header.

=cut

1;
