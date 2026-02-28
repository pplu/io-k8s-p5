package IO::K8s::Api::Core::V1::Affinity;
# ABSTRACT: Affinity is a group of affinity scheduling rules.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s nodeAffinity => 'Core::V1::NodeAffinity';

=attr nodeAffinity

Describes node affinity scheduling rules for the pod.

=cut

k8s podAffinity => 'Core::V1::PodAffinity';

=attr podAffinity

Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).

=cut

k8s podAntiAffinity => 'Core::V1::PodAntiAffinity';

=attr podAntiAffinity

Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).

=cut

1;
