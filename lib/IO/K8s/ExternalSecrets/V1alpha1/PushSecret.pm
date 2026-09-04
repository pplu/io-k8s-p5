package IO::K8s::ExternalSecrets::V1alpha1::PushSecret;
# ABSTRACT: PushSecret is the Schema for the PushSecrets API that enables pushing Kubernetes secrets to external secret providers.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'external-secrets.io/v1alpha1',
    resource_plural => 'pushsecrets';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec';
k8s status => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretStatus';

=attr spec

PushSecretSpec configures the behavior of the PushSecret.

=cut

=attr status

PushSecretStatus indicates the history of the status of PushSecret.

=cut

1;
