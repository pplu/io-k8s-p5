package IO::K8s::Traefik::V1alpha1::MiddlewareTCPSpec;
# ABSTRACT: MiddlewareTCPSpec defines the desired state of a MiddlewareTCP.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s inFlightConn => '+IO::K8s::Traefik::V1alpha1::TCPInFlightConn';
k8s ipAllowList  => '+IO::K8s::Traefik::V1alpha1::TCPIPAllowList';
k8s ipWhiteList  => '+IO::K8s::Traefik::V1alpha1::TCPIPWhiteList';

=attr inFlightConn

InFlightConn defines the InFlightConn middleware configuration.

=cut

=attr ipAllowList

IPAllowList defines the IPAllowList middleware configuration.
This middleware accepts/refuses connections based on the client IP.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/middlewares/ipallowlist/

=cut

=attr ipWhiteList

IPWhiteList defines the IPWhiteList middleware configuration.
This middleware accepts/refuses connections based on the client IP.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/middlewares/ipwhitelist/

Deprecated: please use IPAllowList instead.

=cut

1;
