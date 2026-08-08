package IO::K8s::Api::Certificates::V1beta1::PodCertificateRequest;
# ABSTRACT: PodCertificateRequest encapsulates a pod's request for a certificate from a signer, as well as the signer's response, if any.
our $VERSION = '1.106';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

PodCertificateRequest encapsulates a pod's request for a certificate from a signer, as well as the signer's response, if any.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Certificates::V1beta1::PodCertificateRequestSpec', 'required';

=attr spec

spec contains the details about the certificate being requested.


=cut

k8s status => 'Certificates::V1beta1::PodCertificateRequestStatus';

=attr status

status contains the issued certificate, and a standard set of conditions.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#podcertificaterequest-v1beta1-certificates.k8s.io>


=cut
1;
