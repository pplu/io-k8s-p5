package IO::K8s::Api::Certificates::V1::PodCertificateRequest;
# ABSTRACT: PodCertificateRequest encodes a pod requesting a certificate from a given signer. Kubelets use this API to implement podCertificate projected volumes
our $VERSION = '1.108';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

PodCertificateRequest encodes a pod requesting a certificate from a given signer.

Kubelets use this API to implement podCertificate projected volumes

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Certificates::V1::PodCertificateRequestSpec', 'required';

=attr spec

spec contains the details about the certificate being requested.

=cut

k8s status => 'Certificates::V1::PodCertificateRequestStatus';

=attr status

status contains the issued certificate, and a standard set of conditions.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.37/#podcertificaterequest-v1-certificates.k8s.io>


=cut
1;
