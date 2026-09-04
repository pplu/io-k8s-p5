package IO::K8s::PrometheusOperator::V1alpha1::SecretOrConfigMap;
# ABSTRACT: cert defines the Client certificate to present when doing client-authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s configMap => 'Core::V1::ConfigMapKeySelector';
k8s secret    => 'Core::V1::ConfigMapKeySelector';

=attr configMap

configMap defines the ConfigMap containing data to use for the targets.

=cut

=attr secret

secret defines the Secret containing data to use for the targets.

=cut

1;
