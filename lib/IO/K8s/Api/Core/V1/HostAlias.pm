package IO::K8s::Api::Core::V1::HostAlias;
# ABSTRACT: HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s hostnames => [Str];

=attr hostnames

Hostnames for the above IP address.

=cut

k8s ip => Str, 'required';

=attr ip

IP address of the host file entry.

=cut

1;
