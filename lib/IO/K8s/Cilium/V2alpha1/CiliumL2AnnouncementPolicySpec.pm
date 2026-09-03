package IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicySpec;
# ABSTRACT: Spec is a human readable description of a L2 announcement policy
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s externalIPs     => Bool;
k8s interfaces      => [Str];
k8s loadBalancerIPs => Bool;
k8s nodeSelector    => 'Meta::V1::LabelSelector';
k8s serviceSelector => 'Meta::V1::LabelSelector';

=attr externalIPs

If true, the external IPs of the services are announced

=cut

=attr interfaces

A list of regular expressions that express which network interface(s) should be used
to announce the services over. If nil, all network interfaces are used.

=cut

=attr loadBalancerIPs

If true, the loadbalancer IPs of the services are announced

If nil this policy applies to all services.

=cut

=attr nodeSelector

NodeSelector selects a group of nodes which will announce the IPs for
the services selected by the service selector.

If nil this policy applies to all nodes.

=cut

=attr serviceSelector

ServiceSelector selects a set of services which will be announced over L2 networks.
The loadBalancerClass for a service must be nil or specify a supported class, e.g.
"io.cilium/l2-announcer". Refer to the following document for additional details
regarding load balancer classes:

  https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-class

If nil this policy applies to all services.

=cut

1;
