package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ServerAddressByClientCIDR;
# ABSTRACT: ServerAddressByClientCIDR helps the client to determine the server address that they should use, depending on the clientCIDR that they match.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s clientCIDR => Str, 'required';

=attr clientCIDR

The CIDR with which clients can match their IP to figure out the server address that they should use.

=cut

k8s serverAddress => Str, 'required';

=attr serverAddress

Address of this server, suitable for a client that matches the above CIDR. This can be a hostname, hostname:port, IP or IP:port.

=cut

1;
