package IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfigSpec;
# ABSTRACT: Spec is a human-readable of a GatewayClass configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s description => Str;
k8s envoy       => '+IO::K8s::Cilium::V2alpha1::EnvoyConfig';
k8s httpOptions => '+IO::K8s::Cilium::V2alpha1::HTTPOptions';
k8s service     => '+IO::K8s::Cilium::V2alpha1::ServiceConfig';
k8s telemetry   => '+IO::K8s::Cilium::V2alpha1::Telemetry';

=attr description

Description helps describe a GatewayClass configuration with more details.

=cut

=attr envoy

Envoy specifies proxy configuration options.
These settings control Envoy-specific behavior that is not part of the Gateway API standard.

=cut

=attr httpOptions

HTTPOptions specifies HTTP connection manager options.

=cut

=attr service

Service specifies the configuration for the generated Service.
Note that not all fields from upstream Service.Spec are supported

=cut

=attr telemetry

Telemetry specifies observability options for Gateways using this
GatewayClass configuration.

=cut

1;
