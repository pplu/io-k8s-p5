package IO::K8s::AgentSandbox::V1beta1::PodSpec;
# ABSTRACT: PodSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s activeDeadlineSeconds         => Int;
k8s affinity                      => 'Core::V1::Affinity';
k8s automountServiceAccountToken  => Bool;
k8s containers                    => ['Core::V1::Container'], { required => 'schema' };
k8s dnsConfig                     => 'Core::V1::PodDNSConfig';
k8s dnsPolicy                     => Str;
k8s enableServiceLinks            => Bool;
k8s ephemeralContainers           => ['Core::V1::EphemeralContainer'];
k8s hostAliases                   => ['Core::V1::HostAlias'];
k8s hostIPC                       => Bool;
k8s hostNetwork                   => Bool;
k8s hostPID                       => Bool;
k8s hostUsers                     => Bool;
k8s hostname                      => Str;
k8s hostnameOverride              => Str;
k8s imagePullSecrets              => ['+IO::K8s::AgentSandbox::V1beta1::LocalObjectReference'];
k8s initContainers                => ['Core::V1::Container'];
k8s nodeName                      => Str;
k8s nodeSelector                  => { Str => 1 };
k8s os                            => '+IO::K8s::AgentSandbox::V1beta1::PodOS';
k8s overhead                      => { Str => 1 };
k8s preemptionPolicy              => Str;
k8s priority                      => Int;
k8s priorityClassName             => Str;
k8s readinessGates                => ['+IO::K8s::AgentSandbox::V1beta1::PodReadinessGate'];
k8s resourceClaims                => ['Core::V1::PodResourceClaim'];
k8s resources                     => 'Core::V1::ResourceRequirements';
k8s restartPolicy                 => Str;
k8s runtimeClassName              => Str;
k8s schedulerName                 => Str;
k8s schedulingGates               => ['+IO::K8s::AgentSandbox::V1beta1::PodSchedulingGate'];
k8s schedulingGroup               => '+IO::K8s::AgentSandbox::V1beta1::PodSchedulingGroup';
k8s securityContext               => 'Core::V1::PodSecurityContext';
k8s serviceAccount                => Str;
k8s serviceAccountName            => Str;
k8s setHostnameAsFQDN             => Bool;
k8s shareProcessNamespace         => Bool;
k8s subdomain                     => Str;
k8s terminationGracePeriodSeconds => Int;
k8s tolerations                   => ['Core::V1::Toleration'];
k8s topologySpreadConstraints     => ['Core::V1::TopologySpreadConstraint'];
k8s volumes                       => ['Core::V1::Volume'];

=attr activeDeadlineSeconds

No description in the upstream schema.

=cut

=attr affinity

No description in the upstream schema.

=cut

=attr automountServiceAccountToken

No description in the upstream schema.

=cut

=attr containers

No description in the upstream schema.

=cut

=attr dnsConfig

No description in the upstream schema.

=cut

=attr dnsPolicy

No description in the upstream schema.

=cut

=attr enableServiceLinks

No description in the upstream schema.

=cut

=attr ephemeralContainers

No description in the upstream schema.

=cut

=attr hostAliases

No description in the upstream schema.

=cut

=attr hostIPC

No description in the upstream schema.

=cut

=attr hostNetwork

No description in the upstream schema.

=cut

=attr hostPID

No description in the upstream schema.

=cut

=attr hostUsers

No description in the upstream schema.

=cut

=attr hostname

No description in the upstream schema.

=cut

=attr hostnameOverride

No description in the upstream schema.

=cut

=attr imagePullSecrets

No description in the upstream schema.

=cut

=attr initContainers

No description in the upstream schema.

=cut

=attr nodeName

No description in the upstream schema.

=cut

=attr nodeSelector

No description in the upstream schema.

=cut

=attr os

No description in the upstream schema.

=cut

=attr overhead

No description in the upstream schema.

=cut

=attr preemptionPolicy

No description in the upstream schema.

=cut

=attr priority

No description in the upstream schema.

=cut

=attr priorityClassName

No description in the upstream schema.

=cut

=attr readinessGates

No description in the upstream schema.

=cut

=attr resourceClaims

No description in the upstream schema.

=cut

=attr resources

No description in the upstream schema.

=cut

=attr restartPolicy

No description in the upstream schema.

=cut

=attr runtimeClassName

No description in the upstream schema.

=cut

=attr schedulerName

No description in the upstream schema.

=cut

=attr schedulingGates

No description in the upstream schema.

=cut

=attr schedulingGroup

No description in the upstream schema.

=cut

=attr securityContext

No description in the upstream schema.

=cut

=attr serviceAccount

No description in the upstream schema.

=cut

=attr serviceAccountName

No description in the upstream schema.

=cut

=attr setHostnameAsFQDN

No description in the upstream schema.

=cut

=attr shareProcessNamespace

No description in the upstream schema.

=cut

=attr subdomain

No description in the upstream schema.

=cut

=attr terminationGracePeriodSeconds

No description in the upstream schema.

=cut

=attr tolerations

No description in the upstream schema.

=cut

=attr topologySpreadConstraints

No description in the upstream schema.

=cut

=attr volumes

No description in the upstream schema.

=cut

1;
