package IO::K8s::Api::Discovery::V1::EndpointSlice;
# ABSTRACT: EndpointSlice represents a subset of the endpoints that implement a service. For a given service there may be multiple EndpointSlice objects, selected by labels, which must be joined to produce the full set of endpoints.
our $VERSION = '1.001';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

EndpointSlice represents a subset of the endpoints that implement a service. For a given service there may be multiple EndpointSlice objects, selected by labels, which must be joined to produce the full set of endpoints.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s addressType => Str, 'required';

=attr addressType

addressType specifies the type of address carried by this EndpointSlice. All addresses in this slice must be the same type. This field is immutable after creation. The following address types are currently supported: * IPv4: Represents an IPv4 Address. * IPv6: Represents an IPv6 Address. * FQDN: Represents a Fully Qualified Domain Name.


=cut

k8s endpoints => ['Discovery::V1::Endpoint'], 'required';

=attr endpoints

endpoints is a list of unique endpoints in this slice. Each slice may include a maximum of 1000 endpoints.


=cut

k8s ports => ['Discovery::V1::EndpointPort'];

=attr ports

ports specifies the list of network ports exposed by each endpoint in this slice. Each port must have a unique name. When ports is empty, it indicates that there are no defined ports. When a port is defined with a nil port value, it indicates "all ports". Each slice may include a maximum of 100 ports.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#endpointslice-v1-discovery.k8s.io>


=cut
1;
