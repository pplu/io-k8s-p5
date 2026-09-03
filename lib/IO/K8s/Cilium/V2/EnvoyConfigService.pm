package IO::K8s::Cilium::V2::EnvoyConfigService;
# ABSTRACT: EnvoyConfigService
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name      => Str, { required => 'schema' };
k8s namespace => Str;
k8s number    => [Str];

=attr name

Name is the name of a destination Kubernetes service that identifies traffic
to be redirected.

=cut

=attr namespace

Namespace is the Kubernetes service namespace.
In CiliumEnvoyConfig namespace defaults to the namespace of the CEC,
In CiliumClusterwideEnvoyConfig namespace defaults to "default".

=cut

=attr number

Ports is a set of port numbers, which can be used for filtering in case of underlying
is exposing multiple port numbers.

=cut

1;
