package IO::K8s::Api::Core::V1::PodDNSConfigOption;
# ABSTRACT: PodDNSConfigOption defines DNS resolver options of a pod.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s name => Str;

=attr name

Required.

=cut

k8s value => Str;

1;
