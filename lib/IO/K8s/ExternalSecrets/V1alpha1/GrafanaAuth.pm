package IO::K8s::ExternalSecrets::V1alpha1::GrafanaAuth;
# ABSTRACT: Auth is the authentication configuration to authenticate against the Grafana instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s basic => '+IO::K8s::ExternalSecrets::V1alpha1::GrafanaBasicAuth';
k8s token => '+IO::K8s::ExternalSecrets::V1alpha1::SecretRef';

=attr basic

Basic auth credentials used to authenticate against the Grafana instance.
Note: you need a token which has elevated permissions to create service accounts.
See here for the documentation on basic roles offered by Grafana:
https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/

=cut

=attr token

A service account token used to authenticate against the Grafana instance.
Note: you need a token which has elevated permissions to create service accounts.
See here for the documentation on basic roles offered by Grafana:
https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/

=cut

1;
