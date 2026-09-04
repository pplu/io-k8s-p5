package IO::K8s::PrometheusOperator::V1::AlertmanagerSpec;
# ABSTRACT: spec defines the specification of the desired behavior of the Alertmanager cluster.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s additionalArgs                       => ['+IO::K8s::PrometheusOperator::V1::Argument'];
k8s additionalPeers                      => [Str];
k8s affinity                             => 'Core::V1::Affinity';
k8s alertmanagerConfigMatcherStrategy    => '+IO::K8s::PrometheusOperator::V1::AlertmanagerConfigMatcherStrategy';
k8s alertmanagerConfigNamespaceSelector  => 'Meta::V1::LabelSelector';
k8s alertmanagerConfigSelector           => 'Meta::V1::LabelSelector';
k8s alertmanagerConfiguration            => '+IO::K8s::PrometheusOperator::V1::AlertmanagerConfiguration';
k8s automountServiceAccountToken         => Bool;
k8s baseImage                            => Str;
k8s clusterAdvertiseAddress              => Str;
k8s clusterGossipInterval                => Str, { pattern => qr/^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s clusterLabel                         => Str;
k8s clusterPeerTimeout                   => Str, { pattern => qr/^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s clusterPushpullInterval              => Str, { pattern => qr/^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s clusterTLS                           => '+IO::K8s::PrometheusOperator::V1::ClusterTLSConfig';
k8s configMaps                           => [Str];
k8s configSecret                         => Str;
k8s containers                           => ['Core::V1::Container'];
k8s dnsConfig                            => 'Core::V1::PodDNSConfig';
k8s dnsPolicy                            => Str, { enum => [qw(ClusterFirstWithHostNet ClusterFirst Default None)] };
k8s enableFeatures                       => [Str];
k8s enableServiceLinks                   => Bool;
k8s externalUrl                          => Str;
k8s forceEnableClusterMode               => Bool;
k8s hostAliases                          => ['Core::V1::HostAlias'];
k8s hostNetwork                          => Bool;
k8s hostUsers                            => Bool;
k8s image                                => Str;
k8s imagePullPolicy                      => Str, { enum => ['','Always','Never','IfNotPresent'] };
k8s imagePullSecrets                     => ['Core::V1::LocalObjectReference'];
k8s initContainers                       => ['Core::V1::Container'];
k8s limits                               => '+IO::K8s::PrometheusOperator::V1::AlertmanagerLimitsSpec';
k8s listenLocal                          => Bool;
k8s logFormat                            => Str, { enum => ['','logfmt','json'] };
k8s logLevel                             => Str, { enum => ['','debug','info','warn','error'] };
k8s minReadySeconds                      => Int, { minimum => 0 };
k8s nodeSelector                         => { Str => 1 };
k8s paused                               => Bool;
k8s persistentVolumeClaimRetentionPolicy => 'Apps::V1::StatefulSetPersistentVolumeClaimRetentionPolicy';
k8s podManagementPolicy                  => Str, { enum => [qw(OrderedReady Parallel)] };
k8s podMetadata                          => '+IO::K8s::PrometheusOperator::V1::EmbeddedObjectMetadata';
k8s portName                             => Str, { default => 'web' };
k8s priorityClassName                    => Str;
k8s replicas                             => Int;
k8s resources                            => 'Core::V1::ResourceRequirements';
k8s retention                            => Str, { pattern => qr/^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/, default => '120h' };
k8s routePrefix                          => Str;
k8s schedulerName                        => Str;
k8s secrets                              => [Str];
k8s securityContext                      => 'Core::V1::PodSecurityContext';
k8s serviceAccountName                   => Str;
k8s serviceName                          => Str;
k8s sha                                  => Str;
k8s storage                              => '+IO::K8s::PrometheusOperator::V1::StorageSpec';
k8s tag                                  => Str;
k8s terminationGracePeriodSeconds        => Int, { minimum => 0 };
k8s tolerations                          => ['Core::V1::Toleration'];
k8s topologySpreadConstraints            => ['Core::V1::TopologySpreadConstraint'];
k8s updateStrategy                       => '+IO::K8s::PrometheusOperator::V1::StatefulSetUpdateStrategy';
k8s version                              => Str;
k8s volumeMounts                         => ['+IO::K8s::PrometheusOperator::V1::VolumeMount'];
k8s volumes                              => ['Core::V1::Volume'];
k8s web                                  => '+IO::K8s::PrometheusOperator::V1::AlertmanagerWebSpec';

=attr additionalArgs

additionalArgs allows setting additional arguments for the 'Alertmanager' container.
It is intended for e.g. activating hidden flags which are not supported by
the dedicated configuration options yet. The arguments are passed as-is to the
Alertmanager container which may cause issues if they are invalid or not supported
by the given Alertmanager version.

=cut

=attr additionalPeers

additionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster.

=cut

=attr affinity

affinity defines the pod's scheduling constraints.

=cut

=attr alertmanagerConfigMatcherStrategy

alertmanagerConfigMatcherStrategy defines how AlertmanagerConfig objects
process incoming alerts.

=cut

=attr alertmanagerConfigNamespaceSelector

alertmanagerConfigNamespaceSelector defines the namespaces to be selected for AlertmanagerConfig discovery. If nil, only
check own namespace.

=cut

=attr alertmanagerConfigSelector

alertmanagerConfigSelector defines the selector to be used for to merge and configure Alertmanager with.

=cut

=attr alertmanagerConfiguration

alertmanagerConfiguration defines the configuration of Alertmanager.

If defined, it takes precedence over the `configSecret` field.

This is an *experimental feature*, it may change in any upcoming release
in a breaking way.

=cut

=attr automountServiceAccountToken

automountServiceAccountToken defines whether a service account token should be automatically mounted in the pod.
If the service account has `automountServiceAccountToken: true`, set the field to `false` to opt out of automounting API credentials.

=cut

=attr baseImage

baseImage that is used to deploy pods, without tag.
Deprecated: use 'image' instead.

=cut

=attr clusterAdvertiseAddress

clusterAdvertiseAddress defines the explicit address to advertise in cluster.
Needs to be provided for non RFC1918 [1] (public) addresses.
[1] RFC1918: https://tools.ietf.org/html/rfc1918

=cut

=attr clusterGossipInterval

clusterGossipInterval defines the interval between gossip attempts.

=cut

=attr clusterLabel

clusterLabel defines the identifier that uniquely identifies the Alertmanager cluster.
You should only set it when the Alertmanager cluster includes Alertmanager instances which are external to this Alertmanager resource. In practice, the addresses of the external instances are provided via the `.spec.additionalPeers` field.

=cut

=attr clusterPeerTimeout

clusterPeerTimeout defines the timeout for cluster peering.

=cut

=attr clusterPushpullInterval

clusterPushpullInterval defines the interval between pushpull attempts.

=cut

=attr clusterTLS

clusterTLS defines the mutual TLS configuration for the Alertmanager cluster's gossip protocol.

It requires Alertmanager >= 0.24.0.

=cut

=attr configMaps

configMaps defines a list of ConfigMaps in the same namespace as the Alertmanager
object, which shall be mounted into the Alertmanager Pods.
Each ConfigMap is added to the StatefulSet definition as a volume named `configmap-<configmap-name>`.
The ConfigMaps are mounted into `/etc/alertmanager/configmaps/<configmap-name>` in the 'alertmanager' container.

=cut

=attr configSecret

configSecret defines the name of a Kubernetes Secret in the same namespace as the
Alertmanager object, which contains the configuration for this Alertmanager
instance. If empty, it defaults to `alertmanager-<alertmanager-name>`.

The Alertmanager configuration should be available under the
`alertmanager.yaml` key. Additional keys from the original secret are
copied to the generated secret and mounted into the
`/etc/alertmanager/config` directory in the `alertmanager` container.

If either the secret or the `alertmanager.yaml` key is missing, the
operator provisions a minimal Alertmanager configuration with one empty
receiver (effectively dropping alert notifications).

=cut

=attr containers

containers allows injecting additional containers or modifying operator
generated containers. This can be used to allow adding an authentication
proxy to the Pods or to change the behavior of an operator generated
container. Containers described here modify an operator generated
container if they share the same name and modifications are done via a
strategic merge patch.

The names of containers managed by the operator are:
* `alertmanager`
* `config-reloader`
* `thanos-sidecar`

Overriding containers which are managed by the operator require careful
testing, especially when upgrading to a new version of the operator.

=cut

=attr dnsConfig

dnsConfig defines the DNS configuration for the pods.

=cut

=attr dnsPolicy

dnsPolicy defines the DNS policy for the pods.

=cut

=attr enableFeatures

enableFeatures defines the Alertmanager's feature flags. By default, no features are enabled.
Enabling features which are disabled by default is entirely outside the
scope of what the maintainers will support and by doing so, you accept
that this behaviour may break at any time without notice.

It requires Alertmanager >= 0.27.0.

=cut

=attr enableServiceLinks

enableServiceLinks defines whether information about services should be injected into pod's environment variables

=cut

=attr externalUrl

externalUrl defines the URL used to access the Alertmanager web service. This is
necessary to generate correct URLs. This is necessary if Alertmanager is not
served from root of a DNS name.

=cut

=attr forceEnableClusterMode

forceEnableClusterMode ensures Alertmanager does not deactivate the cluster mode when running with a single replica.
Use case is e.g. spanning an Alertmanager cluster across Kubernetes clusters with a single replica in each.

=cut

=attr hostAliases

hostAliases Pods configuration

=cut

=attr hostNetwork

hostNetwork controls whether the pod may use the node network namespace.

Make sure to understand the security implications if you want to enable
it (https://kubernetes.io/docs/concepts/configuration/overview/).

When hostNetwork is enabled, this will set the DNS policy to
`ClusterFirstWithHostNet` automatically (unless `.spec.dnsPolicy` is set
to a different value).

=cut

=attr hostUsers

hostUsers supports the user space in Kubernetes.

More info: https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/

The feature requires at least Kubernetes 1.28 with the `UserNamespacesSupport` feature gate enabled.
Starting Kubernetes 1.33, the feature is enabled by default.

=cut

=attr image

image if specified has precedence over baseImage, tag and sha
combinations. Specifying the version is still necessary to ensure the
Prometheus Operator knows what version of Alertmanager is being
configured.

=cut

=attr imagePullPolicy

imagePullPolicy for the 'alertmanager', 'init-config-reloader' and 'config-reloader' containers.
See https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy for more details.

=cut

=attr imagePullSecrets

imagePullSecrets An optional list of references to secrets in the same namespace
to use for pulling prometheus and alertmanager images from registries
see https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

=cut

=attr initContainers

initContainers allows injecting initContainers to the Pod definition. Those
can be used to e.g.  fetch secrets for injection into the Prometheus
configuration from external sources. Any errors during the execution of
an initContainer will lead to a restart of the Pod. More info:
https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
InitContainers described here modify an operator generated init
containers if they share the same name and modifications are done via a
strategic merge patch.

The names of init container name managed by the operator are:
* `init-config-reloader`.

Overriding init containers which are managed by the operator require
careful testing, especially when upgrading to a new version of the
operator.

=cut

=attr limits

limits defines the limits command line flags when starting Alertmanager.

=cut

=attr listenLocal

listenLocal defines the Alertmanager server listen on loopback, so that it
does not bind against the Pod IP. Note this is only for the Alertmanager
UI, not the gossip communication.

=cut

=attr logFormat

logFormat for Alertmanager to be configured with.

=cut

=attr logLevel

logLevel for Alertmanager to be configured with.

=cut

=attr minReadySeconds

minReadySeconds defines the minimum number of seconds for which a newly
created pod should be ready without any of its container crashing for it
to be considered available.

If unset, pods will be considered available as soon as they are ready.

When the Alertmanager version is greater than or equal to v0.30.0, the
duration is also used to delay the first flush of the aggregation
groups. This delay helps ensuring that all alerts have been resent by
the Prometheus instances to Alertmanager after a roll-out. It is
possible to override this behavior passing a custom value via
`.spec.additionalArgs`.

=cut

=attr nodeSelector

nodeSelector defines which Nodes the Pods are scheduled on.

=cut

=attr paused

paused if set to true all actions on the underlying managed objects are not
going to be performed, except for delete actions.

=cut

=attr persistentVolumeClaimRetentionPolicy

persistentVolumeClaimRetentionPolicy controls if and how PVCs are deleted during the lifecycle of a StatefulSet.
The default behavior is all PVCs are retained.
This is an alpha field from kubernetes 1.23 until 1.26 and a beta field from 1.26.
It requires enabling the StatefulSetAutoDeletePVC feature gate.

=cut

=attr podManagementPolicy

podManagementPolicy defines the policy for creating/deleting pods when
scaling up and down.

Unlike the default StatefulSet behavior, the default policy is
`Parallel` to avoid manual intervention in case a pod gets stuck during
a rollout.

Note that updating this value implies the recreation of the StatefulSet
which incurs a service outage.

=cut

=attr podMetadata

podMetadata defines labels and annotations which are propagated to the Alertmanager pods.

The following items are reserved and cannot be overridden:
* "alertmanager" label, set to the name of the Alertmanager instance.
* "app.kubernetes.io/instance" label, set to the name of the Alertmanager instance.
* "app.kubernetes.io/managed-by" label, set to "prometheus-operator".
* "app.kubernetes.io/name" label, set to "alertmanager".
* "app.kubernetes.io/version" label, set to the Alertmanager version.
* "kubectl.kubernetes.io/default-container" annotation, set to "alertmanager".

=cut

=attr portName

portName defines the port's name for the pods and governing service.
Defaults to `web`.

=cut

=attr priorityClassName

priorityClassName assigned to the Pods

=cut

=attr replicas

replicas defines the expected size of the alertmanager cluster. The controller will
eventually make the size of the running cluster equal to the expected
size.

=cut

=attr resources

resources defines the resource requests and limits of the Pods.

=cut

=attr retention

retention defines the time duration Alertmanager shall retain data for. Default is '120h',
and must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours).

=cut

=attr routePrefix

routePrefix Alertmanager registers HTTP handlers for. This is useful,
if using ExternalURL and a proxy is rewriting HTTP routes of a request,
and the actual ExternalURL is still true, but the server serves requests
under a different route prefix. For example for use with `kubectl proxy`.

=cut

=attr schedulerName

schedulerName defines the scheduler to use for Pod scheduling. If not specified, the default scheduler is used.

=cut

=attr secrets

secrets is a list of Secrets in the same namespace as the Alertmanager
object, which shall be mounted into the Alertmanager Pods.
Each Secret is added to the StatefulSet definition as a volume named `secret-<secret-name>`.
The Secrets are mounted into `/etc/alertmanager/secrets/<secret-name>` in the 'alertmanager' container.

=cut

=attr securityContext

securityContext holds pod-level security attributes and common container settings.
This defaults to the default PodSecurityContext.

=cut

=attr serviceAccountName

serviceAccountName is the name of the ServiceAccount to use to run the
Prometheus Pods.

=cut

=attr serviceName

serviceName defines the service name used by the underlying StatefulSet(s) as the governing service.
If defined, the Service  must be created before the Alertmanager resource in the same namespace and it must define a selector that matches the pod labels.
If empty, the operator will create and manage a headless service named `alertmanager-operated` for Alertmanager resources.
When deploying multiple Alertmanager resources in the same namespace, it is recommended to specify a different value for each.
See https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id for more details.

=cut

=attr sha

sha of Alertmanager container image to be deployed. Defaults to the value of `version`.
Similar to a tag, but the SHA explicitly deploys an immutable container image.
Version and Tag are ignored if SHA is set.
Deprecated: use 'image' instead. The image digest can be specified as part of the image URL.

=cut

=attr storage

storage defines the definition of how storage will be used by the Alertmanager
instances.

=cut

=attr tag

tag of Alertmanager container image to be deployed. Defaults to the value of `version`.
Version is ignored if Tag is set.
Deprecated: use 'image' instead. The image tag can be specified as part of the image URL.

=cut

=attr terminationGracePeriodSeconds

terminationGracePeriodSeconds defines the Optional duration in seconds the pod needs to terminate gracefully.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down) which may lead to data corruption.

Defaults to 120 seconds.

=cut

=attr tolerations

tolerations defines the pod's tolerations.

=cut

=attr topologySpreadConstraints

topologySpreadConstraints defines the Pod's topology spread constraints.

=cut

=attr updateStrategy

updateStrategy indicates the strategy that will be employed to update
Pods in the StatefulSet when a revision is made to statefulset's Pod
Template.

The default strategy is RollingUpdate.

=cut

=attr version

version the cluster should be on.

=cut

=attr volumeMounts

volumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition.
VolumeMounts specified will be appended to other VolumeMounts in the alertmanager container,
that are generated as a result of StorageSpec objects.

=cut

=attr volumes

volumes allows configuration of additional volumes on the output StatefulSet definition.
Volumes specified will be appended to other volumes that are generated as a result of
StorageSpec objects.

=cut

=attr web

web defines the web command line flags when starting Alertmanager.

=cut

1;
