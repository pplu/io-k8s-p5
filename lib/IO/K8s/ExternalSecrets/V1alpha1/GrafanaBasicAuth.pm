package IO::K8s::ExternalSecrets::V1alpha1::GrafanaBasicAuth;
# ABSTRACT: Basic auth credentials used to authenticate against the Grafana instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s password => '+IO::K8s::ExternalSecrets::V1alpha1::SecretRef', { required => 'schema' };
k8s username => Str, { required => 'schema' };

=attr password

A basic auth password used to authenticate against the Grafana instance.

=cut

=attr username

A basic auth username used to authenticate against the Grafana instance.

=cut

1;
