package IO::K8s::Cilium::V2alpha1::IPPoolSpec;
# ABSTRACT: IPPoolSpec
our $VERSION = '1.108';
use utf8;
use IO::K8s::Resource;

k8s allowFirstIP      => Bool, { default => 0 };
k8s allowLastIP       => Bool, { default => 0 };
k8s ipv4              => '+IO::K8s::Cilium::V2alpha1::IPv4PoolSpec';
k8s ipv6              => '+IO::K8s::Cilium::V2alpha1::IPv6PoolSpec';
k8s namespaceSelector => 'Meta::V1::LabelSelector';
k8s podSelector       => 'Meta::V1::LabelSelector';

=encoding UTF-8

=cut

=attr allowFirstIP

AllowFirstIP allows the first IP of each allocated CIDR to be used. If
unset or false, this IP is reserved. This field is ignored for /{31,32}
and /{127,128} CIDRs since reserving the first and last IPs would make
the CIDRs unusable. This field is immutable.

=cut

=attr allowLastIP

AllowLastIP allows the last IP of each allocated CIDR to be used. If
unset or false, this IP is reserved. This field is ignored for /{31,32}
and /{127,128} CIDRs since reserving the first and last IPs would make
the CIDRs unusable. This field is immutable.

=cut

=attr ipv4

IPv4 specifies the IPv4 CIDRs and mask sizes of the pool

=cut

=attr ipv6

IPv6 specifies the IPv6 CIDRs and mask sizes of the pool

=cut

=attr namespaceSelector

NamespaceSelector selects the set of Namespaces that are eligible to use
this pool. If both PodSelector and NamespaceSelector are specified, a Pod
must match both selectors to be eligible for IP allocation from this pool.

If NamespaceSelector is empty, the pool can be used by Pods in any namespace
(subject to PodSelector constraints).

=cut

=attr podSelector

PodSelector selects the set of Pods that are eligible to receive IPs from
this pool when neither the Pod nor its Namespace specify an explicit
`ipam.cilium.io/*` annotation.

The selector can match on regular Pod labels and on the following synthetic
labels that Cilium adds for convenience:

io.kubernetes.pod.namespace – the Pod's namespace
io.kubernetes.pod.name      – the Pod's name

A single Pod must not match more than one pool for the same IP family.
If multiple pools match, IP allocation fails for that Pod and a warning event
is emitted in the namespace of the Pod.

=cut

1;
