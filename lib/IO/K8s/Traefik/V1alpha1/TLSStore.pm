package IO::K8s::Traefik::V1alpha1::TLSStore;
# ABSTRACT: TLSStore is the CRD implementation of a Traefik TLS Store.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'tlsstores';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::TLSStoreSpec', { required => 'schema' };

=attr spec

TLSStoreSpec defines the desired state of a TLSStore.

=cut

1;
