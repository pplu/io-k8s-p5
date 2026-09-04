package IO::K8s::ExternalSecrets::V1::GCPSMAuthSecretRef;
# ABSTRACT: Specify credentials in a Secret object
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretAccessKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr secretAccessKeySecretRef

The SecretAccessKey is used for authentication

=cut

1;
