package IO::K8s::Cilium::V2::EndpointHealth;
# ABSTRACT: Health is the overall endpoint & subcomponent health.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bpf           => Str;
k8s connected     => Bool;
k8s overallHealth => Str;
k8s policy        => Str;

=attr bpf

bpf

=cut

=attr connected

Is this endpoint reachable

=cut

=attr overallHealth

overall health

=cut

=attr policy

policy

=cut

1;
