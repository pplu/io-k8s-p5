package IO::K8s::Cilium::V2alpha1::ServiceConfig;
# ABSTRACT: Service specifies the configuration for the generated Service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allocateLoadBalancerNodePorts  => Bool;
k8s externalTrafficPolicy          => Str, { default => 'Cluster' };
k8s ipFamilies                     => [Str];
k8s ipFamilyPolicy                 => Str;
k8s loadBalancerClass              => Str;
k8s loadBalancerSourceRanges       => [Str];
k8s loadBalancerSourceRangesPolicy => Str, { enum => [qw(Allow Deny)], default => 'Allow' };
k8s trafficDistribution            => Str;
k8s type                           => Str, { enum => [qw(LoadBalancer NodePort)], default => 'LoadBalancer' };

=attr allocateLoadBalancerNodePorts

Sets the Service.Spec.AllocateLoadBalancerNodePorts in generated Service objects to the given value.

=cut

=attr externalTrafficPolicy

Sets the Service.Spec.ExternalTrafficPolicy in generated Service objects to the given value.

=cut

=attr ipFamilies

Sets the Service.Spec.IPFamilies in generated Service objects to the given value.

=cut

=attr ipFamilyPolicy

Sets the Service.Spec.IPFamilyPolicy in generated Service objects to the given value.

=cut

=attr loadBalancerClass

Sets the Service.Spec.LoadBalancerClass in generated Service objects to the given value.

=cut

=attr loadBalancerSourceRanges

Sets the Service.Spec.LoadBalancerSourceRanges in generated Service objects to the given value.

=cut

=attr loadBalancerSourceRangesPolicy

LoadBalancerSourceRangesPolicy defines the policy for the LoadBalancerSourceRanges if the incoming traffic
is allowed or denied.

=cut

=attr trafficDistribution

Sets the Service.Spec.TrafficDistribution in generated Service objects to the given value.

=cut

=attr type

Sets the Service.Spec.Type in generated Service objects to the given value.
Only LoadBalancer and NodePort are supported.

=cut

1;
