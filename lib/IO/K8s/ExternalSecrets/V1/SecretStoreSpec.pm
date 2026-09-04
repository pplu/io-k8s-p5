package IO::K8s::ExternalSecrets::V1::SecretStoreSpec;
# ABSTRACT: SecretStoreSpec defines the desired state of SecretStore.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions      => ['+IO::K8s::ExternalSecrets::V1::ClusterSecretStoreCondition'];
k8s controller      => Str;
k8s provider        => '+IO::K8s::ExternalSecrets::V1::SecretStoreProvider', { required => 'schema' };
k8s refreshInterval => IntOrStr;
k8s retrySettings   => '+IO::K8s::ExternalSecrets::V1::SecretStoreRetrySettings';

=attr conditions

Used to constrain a ClusterSecretStore to specific namespaces. Relevant only to ClusterSecretStore.

=cut

=attr controller

Used to select the correct ESO controller (think: ingress.ingressClassName)
The ESO controller is instantiated with a specific controller name and filters ES based on this property

=cut

=attr provider

Used to configure the provider. Only one provider may be set

=cut

=attr refreshInterval

Used to configure store refresh interval. Accepts either an integer number
of seconds (legacy) or a Go duration string such as "1h" or "5m". Empty or
0 will default to the controller config.

=cut

=attr retrySettings

Used to configure HTTP retries on failures.

=cut

1;
