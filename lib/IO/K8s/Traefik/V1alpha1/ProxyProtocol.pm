package IO::K8s::Traefik::V1alpha1::ProxyProtocol;
# ABSTRACT: ProxyProtocol holds the PROXY Protocol configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s version => Int, { minimum => 1, maximum => 2 };

=attr version

Version defines the PROXY Protocol version to use.

=cut

1;
