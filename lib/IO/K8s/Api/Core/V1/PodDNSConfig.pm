package IO::K8s::Api::Core::V1::PodDNSConfig;
# ABSTRACT: PodDNSConfig defines the DNS parameters of a pod in addition to those generated from DNSPolicy.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s nameservers => [Str];

=attr nameservers

A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.

=cut

k8s options => ['Core::V1::PodDNSConfigOption'];

=attr options

A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.

=cut

k8s searches => [Str];

=attr searches

A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.

=cut

1;
