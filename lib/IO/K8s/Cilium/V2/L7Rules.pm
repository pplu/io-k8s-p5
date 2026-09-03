package IO::K8s::Cilium::V2::L7Rules;
# ABSTRACT: Rules is a list of additional port level rules which must be met in order for the PortRule to allow the traffic.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dns  => ['+IO::K8s::Cilium::V2::PortRuleDNS'];
k8s http => ['+IO::K8s::Cilium::V2::PortRuleHTTP'];

=attr dns

DNS-specific rules.

=cut

=attr http

HTTP specific rules.

=cut

1;
