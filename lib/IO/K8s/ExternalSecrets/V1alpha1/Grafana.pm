package IO::K8s::ExternalSecrets::V1alpha1::Grafana;
# ABSTRACT: Grafana represents a generator for Grafana service account tokens.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'grafanas';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::GrafanaSpec';

=attr spec

GrafanaSpec controls the behavior of the grafana generator.

=cut

1;
