package IO::K8s::Traefik::V1alpha1::TLSStoreSpec;
# ABSTRACT: TLSStoreSpec defines the desired state of a TLSStore.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certificates         => ['+IO::K8s::Traefik::V1alpha1::Certificate'];
k8s defaultCertificate   => '+IO::K8s::Traefik::V1alpha1::Certificate';
k8s defaultGeneratedCert => '+IO::K8s::Traefik::V1alpha1::GeneratedCert';

=attr certificates

Certificates is a list of secret names, each secret holding a key/certificate pair to add to the store.

=cut

=attr defaultCertificate

DefaultCertificate defines the default certificate configuration.

=cut

=attr defaultGeneratedCert

DefaultGeneratedCert defines the default generated certificate configuration.

=cut

1;
