package IO::K8s::Traefik::V1alpha1::TraefikService;
# ABSTRACT: TraefikService is the CRD implementation of a Traefik Service.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'traefikservices';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Loadbalanced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::TraefikServiceSpec', { required => 'schema' };

=attr spec

TraefikServiceSpec defines the desired state of a TraefikService.

=cut

1;
