package IO::K8s::PrometheusOperator::V1::GlobalJiraConfig;
# ABSTRACT: jira defines the default configuration for Jira.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiURL => Str, { pattern => qr/^(http|https):\/\/.+$/ };

=attr apiURL

apiURL defines the default Jira API URL.

It requires Alertmanager >= v0.28.0.

=cut

1;
