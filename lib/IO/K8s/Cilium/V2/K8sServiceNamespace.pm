package IO::K8s::Cilium::V2::K8sServiceNamespace;
# ABSTRACT: K8sService selects service by name and namespace pair
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespace   => Str;
k8s serviceName => Str;

=attr namespace

No description in the upstream schema.

=cut

=attr serviceName

No description in the upstream schema.

=cut

1;
