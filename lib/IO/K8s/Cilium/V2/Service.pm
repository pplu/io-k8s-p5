package IO::K8s::Cilium::V2::Service;
# ABSTRACT: Service selects policy targets that are bundled as part of a logical load-balanced service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s k8sService         => '+IO::K8s::Cilium::V2::K8sServiceNamespace';
k8s k8sServiceSelector => '+IO::K8s::Cilium::V2::K8sServiceSelectorNamespace';

=attr k8sService

K8sService selects service by name and namespace pair

=cut

=attr k8sServiceSelector

K8sServiceSelector selects services by k8s labels and namespace

=cut

1;
