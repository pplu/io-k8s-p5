package IO::K8s::Cilium::V2::Rule;
# ABSTRACT: Rule is a policy rule which must be applied to all endpoints which match the labels contained in the endpointSelector Each rule is split into an ingress section which contains all rules applicable at ingress, and an egress section applicable at egress.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s description       => Str;
k8s egress            => ['+IO::K8s::Cilium::V2::EgressRule'];
k8s egressDeny        => ['+IO::K8s::Cilium::V2::EgressDenyRule'];
k8s enableDefaultDeny => '+IO::K8s::Cilium::V2::DefaultDenyConfig';
k8s endpointSelector  => 'Meta::V1::LabelSelector';
k8s ingress           => ['+IO::K8s::Cilium::V2::IngressRule'];
k8s ingressDeny       => ['+IO::K8s::Cilium::V2::IngressDenyRule'];
k8s labels            => ['+IO::K8s::Cilium::V2::Label'];
k8s log               => '+IO::K8s::Cilium::V2::LogConfig';
k8s nodeSelector      => 'Meta::V1::LabelSelector';

=attr description

Description is a free form string, it can be used by the creator of
the rule to store human readable explanation of the purpose of this
rule. Rules cannot be identified by comment.

=cut

=attr egress

Egress is a list of EgressRule which are enforced at egress.
If omitted or empty, this rule does not apply at egress.

=cut

=attr egressDeny

EgressDeny is a list of EgressDenyRule which are enforced at egress.
Any rule inserted here will be denied regardless of the allowed egress
rules in the 'egress' field.
If omitted or empty, this rule does not apply at egress.

=cut

=attr enableDefaultDeny

EnableDefaultDeny determines whether this policy configures the
subject endpoint(s) to have a default deny mode. If enabled,
this causes all traffic not explicitly allowed by a network policy
to be dropped.

If not specified, the default is true for each traffic direction
that has rules, and false otherwise. For example, if a policy
only has Ingress or IngressDeny rules, then the default for
ingress is true and egress is false.

If multiple policies apply to an endpoint, that endpoint's default deny
will be enabled if any policy requests it.

This is useful for creating broad-based network policies that will not
cause endpoints to enter default-deny mode.

=cut

=attr endpointSelector

EndpointSelector selects all endpoints which should be subject to
this rule. EndpointSelector and NodeSelector cannot be both empty and
are mutually exclusive.

=cut

=attr ingress

Ingress is a list of IngressRule which are enforced at ingress.
If omitted or empty, this rule does not apply at ingress.

=cut

=attr ingressDeny

IngressDeny is a list of IngressDenyRule which are enforced at ingress.
Any rule inserted here will be denied regardless of the allowed ingress
rules in the 'ingress' field.
If omitted or empty, this rule does not apply at ingress.

=cut

=attr labels

Labels is a list of optional strings which can be used to
re-identify the rule or to store metadata. It is possible to lookup
or delete strings based on labels. Labels are not required to be
unique, multiple rules can have overlapping or identical labels.

=cut

=attr log

Log specifies custom policy-specific Hubble logging configuration.

=cut

=attr nodeSelector

NodeSelector selects all nodes which should be subject to this rule.
EndpointSelector and NodeSelector cannot be both empty and are mutually
exclusive. Can only be used in CiliumClusterwideNetworkPolicies.

=cut

1;
