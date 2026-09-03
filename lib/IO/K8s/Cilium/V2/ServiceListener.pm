package IO::K8s::Cilium::V2::ServiceListener;
# ABSTRACT: ServiceListener
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s listener  => Str;
k8s name      => Str, { required => 'schema' };
k8s namespace => Str;
k8s ports     => [Int];

=attr listener

Listener specifies the name of the Envoy listener the
service traffic is redirected to. The listener must be
specified in the Envoy 'resources' of the same
CiliumEnvoyConfig.

If omitted, the first listener specified in 'resources' is
used.

=cut

=attr name

Name is the name of a destination Kubernetes service that identifies traffic
to be redirected.

=cut

=attr namespace

Namespace is the Kubernetes service namespace.
In CiliumEnvoyConfig namespace this is overridden to the namespace of the CEC,
In CiliumClusterwideEnvoyConfig namespace defaults to "default".

=cut

=attr ports

Ports is a set of service's frontend ports that should be redirected to the Envoy
listener. By default all frontend ports of the service are redirected.

=cut

1;
