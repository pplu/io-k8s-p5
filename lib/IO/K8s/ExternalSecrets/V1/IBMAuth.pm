package IO::K8s::ExternalSecrets::V1::IBMAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with the IBM secrets manager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s containerAuth => '+IO::K8s::ExternalSecrets::V1::IBMAuthContainerAuth';
k8s secretRef     => '+IO::K8s::ExternalSecrets::V1::IBMAuthSecretRef';

=attr containerAuth

IBMAuthContainerAuth defines container-based authentication with IAM Trusted Profile.

=cut

=attr secretRef

IBMAuthSecretRef contains the secret reference for IBM Cloud API key authentication.

=cut

1;
