package IO::K8s::Cilium::V2::CiliumNodeConfigSpec;
# ABSTRACT: Spec is the desired Cilium configuration overrides for a given node
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s defaults     => { Str => 1 }, { required => 'schema' };
k8s nodeSelector => 'Meta::V1::LabelSelector', { required => 'schema' };

=attr defaults

Defaults is treated the same as the cilium-config ConfigMap - a set
of key-value pairs parsed by the agent and operator processes.
Each key must be a valid config-map data field (i.e. a-z, A-Z, -, _, and .)

=cut

=attr nodeSelector

NodeSelector is a label selector that determines to which nodes
this configuration applies.
If not supplied, then this config applies to no nodes. If
empty, then it applies to all nodes.

=cut

1;
