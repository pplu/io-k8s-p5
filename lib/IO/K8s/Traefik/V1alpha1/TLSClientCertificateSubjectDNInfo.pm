package IO::K8s::Traefik::V1alpha1::TLSClientCertificateSubjectDNInfo;
# ABSTRACT: Subject defines the client certificate subject details to add to the X-Forwarded-Tls-Client-Cert-Info header.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s commonName         => Bool;
k8s country            => Bool;
k8s domainComponent    => Bool;
k8s locality           => Bool;
k8s organization       => Bool;
k8s organizationalUnit => Bool;
k8s province           => Bool;
k8s serialNumber       => Bool;

=attr commonName

CommonName defines whether to add the organizationalUnit information into the subject.

=cut

=attr country

Country defines whether to add the country information into the subject.

=cut

=attr domainComponent

DomainComponent defines whether to add the domainComponent information into the subject.

=cut

=attr locality

Locality defines whether to add the locality information into the subject.

=cut

=attr organization

Organization defines whether to add the organization information into the subject.

=cut

=attr organizationalUnit

OrganizationalUnit defines whether to add the organizationalUnit information into the subject.

=cut

=attr province

Province defines whether to add the province information into the subject.

=cut

=attr serialNumber

SerialNumber defines whether to add the serialNumber information into the subject.

=cut

1;
