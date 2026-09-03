package IO::K8s::Cilium::V2::EnvoyConfig;
# ABSTRACT: EnvoyConfig is a reference to the CEC or CCEC resource in which the listener is defined.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kind => Str, { enum => [qw(CiliumEnvoyConfig CiliumClusterwideEnvoyConfig)] };
k8s name => Str, { required => 'schema' };

=attr kind

Kind is the resource type being referred to. Defaults to CiliumEnvoyConfig or
CiliumClusterwideEnvoyConfig for CiliumNetworkPolicy and CiliumClusterwideNetworkPolicy,
respectively. The only case this is currently explicitly needed is when referring to a
CiliumClusterwideEnvoyConfig from CiliumNetworkPolicy, as using a namespaced listener
from a cluster scoped policy is not allowed.

=cut

=attr name

Name is the resource name of the CiliumEnvoyConfig or CiliumClusterwideEnvoyConfig where
the listener is defined in.

=cut

1;
