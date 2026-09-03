package IO::K8s::Cilium::V2::K8sServiceSelectorNamespace;
# ABSTRACT: K8sServiceSelector selects services by k8s labels and namespace
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespace => Str;
k8s selector  => 'Meta::V1::LabelSelector', { required => 'schema' };

=attr namespace

No description in the upstream schema.

=cut

=attr selector

ServiceSelector is a label selector for k8s services

=cut

1;
