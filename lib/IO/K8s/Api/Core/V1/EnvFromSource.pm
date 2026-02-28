package IO::K8s::Api::Core::V1::EnvFromSource;
# ABSTRACT: EnvFromSource represents the source of a set of ConfigMaps
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s configMapRef => 'Core::V1::ConfigMapEnvSource';

=attr configMapRef

The ConfigMap to select from

=cut

k8s prefix => Str;

=attr prefix

An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER.

=cut

k8s secretRef => 'Core::V1::SecretEnvSource';

=attr secretRef

The Secret to select from

=cut

1;
