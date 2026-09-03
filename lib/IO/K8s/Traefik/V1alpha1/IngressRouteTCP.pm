package IO::K8s::Traefik::V1alpha1::IngressRouteTCP;
# ABSTRACT: IngressRouteTCP is the CRD implementation of a Traefik TCP Router.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'ingressroutetcps';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::IngressRouteTCPSpec', { required => 'schema' };

=attr spec

IngressRouteTCPSpec defines the desired state of IngressRouteTCP.

=cut

1;
