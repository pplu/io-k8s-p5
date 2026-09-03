package IO::K8s::Cilium::V2::Listener;
# ABSTRACT: listener specifies the name of a custom Envoy listener to which this traffic should be redirected to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s envoyConfig => '+IO::K8s::Cilium::V2::EnvoyConfig', { required => 'schema' };
k8s name        => Str, { required => 'schema' };
k8s priority    => Int, { minimum => 1, maximum => 100 };

=attr envoyConfig

EnvoyConfig is a reference to the CEC or CCEC resource in which
the listener is defined.

=cut

=attr name

Name is the name of the listener.

=cut

=attr priority

Priority for this Listener that is used when multiple rules would apply different
listeners to a policy map entry. Behavior of this is implementation dependent.

=cut

1;
