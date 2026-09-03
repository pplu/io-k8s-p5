package IO::K8s::Traefik::V1alpha1::Failover;
# ABSTRACT: Failover defines the Failover service configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s errors   => '+IO::K8s::Traefik::V1alpha1::FailoverError', { required => 'schema' };
k8s fallback => '+IO::K8s::Traefik::V1alpha1::LoadBalancerSpec', { required => 'schema' };
k8s service  => '+IO::K8s::Traefik::V1alpha1::LoadBalancerSpec', { required => 'schema' };

=attr errors

Errors defines which errors should trigger the use of the fallback service.

=cut

=attr fallback

Fallback defines the fallback service to use when the main service returns an error.

=cut

=attr service

Service defines the main service to use.

=cut

1;
