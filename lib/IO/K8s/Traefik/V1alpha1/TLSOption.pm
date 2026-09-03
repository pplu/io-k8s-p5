package IO::K8s::Traefik::V1alpha1::TLSOption;
# ABSTRACT: TLSOption is the CRD implementation of a Traefik TLS Option, allowing to configure some parameters of the TLS connection.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'tlsoptions';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::TLSOptionSpec', { required => 'schema' };

=attr spec

TLSOptionSpec defines the desired state of a TLSOption.

=cut

1;
