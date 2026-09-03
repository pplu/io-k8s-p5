package IO::K8s::Cilium::V2::DefaultDenyConfig;
# ABSTRACT: EnableDefaultDeny determines whether this policy configures the subject endpoint(s) to have a default deny mode.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s egress  => Bool;
k8s ingress => Bool;

=attr egress

Whether or not the endpoint should have a default-deny rule applied
to egress traffic.

=cut

=attr ingress

Whether or not the endpoint should have a default-deny rule applied
to ingress traffic.

=cut

1;
