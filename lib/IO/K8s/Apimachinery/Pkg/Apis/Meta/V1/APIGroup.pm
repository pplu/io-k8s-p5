package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::APIGroup;
# ABSTRACT: APIGroup contains the name, the supported versions, and the preferred version of a group.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources

=cut

k8s kind => Str;

=attr kind

Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds

=cut

k8s name => Str, 'required';

=attr name

name is the name of the group.

=cut

k8s preferredVersion => 'Meta::V1::GroupVersionForDiscovery';

=attr preferredVersion

preferredVersion is the version preferred by the API server, which probably is the storage version.

=cut

k8s serverAddressByClientCIDRs => ['Meta::V1::ServerAddressByClientCIDR'];

=attr serverAddressByClientCIDRs

a map of client CIDR to server address that is serving this group. This is used to help clients reach servers in the most network-efficient way possible. Clients can use the appropriate server address as per the CIDR that they match. In case of multiple matches, clients should use the longest matching CIDR. The server returns only those CIDRs that it thinks that the client can match. For example: the master will return an internal IP CIDR only, if the client reaches the server using an internal IP. Server looks at X-Forwarded-For header or X-Real-Ip header or request.RemoteAddr (in that order) to get the client IP.

=cut

k8s versions => ['Meta::V1::GroupVersionForDiscovery'], 'required';

=attr versions

versions are the versions supported in this group.

=cut

1;
