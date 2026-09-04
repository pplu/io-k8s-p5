package IO::K8s::PrometheusOperator::V1::AlertmanagerConfigMatcherStrategy;
# ABSTRACT: alertmanagerConfigMatcherStrategy defines how AlertmanagerConfig objects process incoming alerts.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type => Str, { enum => [qw(OnNamespace OnNamespaceExceptForAlertmanagerNamespace None)], default => 'OnNamespace' };

=attr type

type defines the strategy used by
AlertmanagerConfig objects to match alerts in the routes and inhibition
rules.

The default value is `OnNamespace`.

=cut

1;
