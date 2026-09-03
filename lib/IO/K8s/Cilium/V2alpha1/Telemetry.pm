package IO::K8s::Cilium::V2alpha1::Telemetry;
# ABSTRACT: Telemetry specifies observability options for Gateways using this GatewayClass configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessLogs => ['+IO::K8s::Cilium::V2alpha1::AccessLogs'];

=attr accessLogs

AccessLogs configures Envoy access logging for generated Gateway
listeners.

=cut

1;
