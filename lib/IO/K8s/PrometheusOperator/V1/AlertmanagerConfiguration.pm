package IO::K8s::PrometheusOperator::V1::AlertmanagerConfiguration;
# ABSTRACT: alertmanagerConfiguration defines the configuration of Alertmanager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s global    => '+IO::K8s::PrometheusOperator::V1::AlertmanagerGlobalConfig';
k8s name      => Str;
k8s templates => ['+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap'];

=attr global

global defines the global parameters of the Alertmanager configuration.

=cut

=attr name

name defines the name of the AlertmanagerConfig custom resource which is used to generate the Alertmanager configuration.
It must be defined in the same namespace as the Alertmanager object.
The operator will not enforce a `namespace` label for routes and inhibition rules.

=cut

=attr templates

templates defines the custom notification templates.

=cut

1;
