package IO::K8s::Api::Core::V1::VolumeProjection;
# ABSTRACT: Projection that may be projected along with other supported volume types. Exactly one of these fields must be set.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s clusterTrustBundle => 'Core::V1::ClusterTrustBundleProjection';

=attr clusterTrustBundle

ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field of ClusterTrustBundle objects in an auto-updating file.

Alpha, gated by the ClusterTrustBundleProjection feature gate.

ClusterTrustBundle objects can either be selected by name, or by the combination of signer name and a label selector.

Kubelet performs aggressive normalization of the PEM contents written into the pod filesystem.  Esoteric PEM features such as inter-block comments and block headers are stripped.  Certificates are deduplicated. The ordering of certificates within the file is arbitrary, and Kubelet may change the order over time.

=cut

k8s configMap => 'Core::V1::ConfigMapProjection';

=attr configMap

configMap information about the configMap data to project

=cut

k8s downwardAPI => 'Core::V1::DownwardAPIProjection';

=attr downwardAPI

downwardAPI information about the downwardAPI data to project

=cut

k8s secret => 'Core::V1::SecretProjection';

=attr secret

secret information about the secret data to project

=cut

k8s serviceAccountToken => 'Core::V1::ServiceAccountTokenProjection';

=attr serviceAccountToken

serviceAccountToken is information about the serviceAccountToken data to project

=cut

1;
