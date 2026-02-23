package IO::K8s::Api::Core::V1::Volume;
# ABSTRACT: Volume represents a named volume in a pod that may be accessed by any container in the pod.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s awsElasticBlockStore => 'Core::V1::AWSElasticBlockStoreVolumeSource';

=attr awsElasticBlockStore

awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore

=cut

k8s azureDisk => 'Core::V1::AzureDiskVolumeSource';

=attr azureDisk

azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.

=cut

k8s azureFile => 'Core::V1::AzureFileVolumeSource';

=attr azureFile

azureFile represents an Azure File Service mount on the host and bind mount to the pod.

=cut

k8s cephfs => 'Core::V1::CephFSVolumeSource';

=attr cephfs

cephFS represents a Ceph FS mount on the host that shares a pod's lifetime

=cut

k8s cinder => 'Core::V1::CinderVolumeSource';

=attr cinder

cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md

=cut

k8s configMap => 'Core::V1::ConfigMapVolumeSource';

=attr configMap

configMap represents a configMap that should populate this volume

=cut

k8s csi => 'Core::V1::CSIVolumeSource';

=attr csi

csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature).

=cut

k8s downwardAPI => 'Core::V1::DownwardAPIVolumeSource';

=attr downwardAPI

downwardAPI represents downward API about the pod that should populate this volume

=cut

k8s emptyDir => 'Core::V1::EmptyDirVolumeSource';

=attr emptyDir

emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir

=cut

k8s ephemeral => 'Core::V1::EphemeralVolumeSource';

=attr ephemeral

ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed.

Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity
   tracking are needed,
c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through
   a PersistentVolumeClaim (see EphemeralVolumeSource for more
   information on the connection between this volume type
   and PersistentVolumeClaim).

Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod.

Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information.

A pod can use both types of ephemeral volumes and persistent volumes at the same time.

=cut

k8s fc => 'Core::V1::FCVolumeSource';

=attr fc

fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.

=cut

k8s flexVolume => 'Core::V1::FlexVolumeSource';

=attr flexVolume

flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.

=cut

k8s flocker => 'Core::V1::FlockerVolumeSource';

=attr flocker

flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running

=cut

k8s gcePersistentDisk => 'Core::V1::GCEPersistentDiskVolumeSource';

=attr gcePersistentDisk

gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk

=cut

k8s gitRepo => 'Core::V1::GitRepoVolumeSource';

=attr gitRepo

gitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.

=cut

k8s glusterfs => 'Core::V1::GlusterfsVolumeSource';

=attr glusterfs

glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md

=cut

k8s hostPath => 'Core::V1::HostPathVolumeSource';

=attr hostPath

hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath

=cut

k8s image => 'Core::V1::ImageVolumeSource';

=attr image

image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine. The volume is resolved at pod startup depending on which PullPolicy value is provided:

- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails. - Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present. - IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.

The volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation. A failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message. The types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field. The OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images. The volume will be mounted read-only (ro) and non-executable files (noexec). Sub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath). The field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.

=cut

k8s iscsi => 'Core::V1::ISCSIVolumeSource';

=attr iscsi

iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md

=cut

k8s name => Str, 'required';

=attr name

name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

k8s nfs => 'Core::V1::NFSVolumeSource';

=attr nfs

nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

=cut

k8s persistentVolumeClaim => 'Core::V1::PersistentVolumeClaimVolumeSource';

=attr persistentVolumeClaim

persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

=cut

k8s photonPersistentDisk => 'Core::V1::PhotonPersistentDiskVolumeSource';

=attr photonPersistentDisk

photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine

=cut

k8s portworxVolume => 'Core::V1::PortworxVolumeSource';

=attr portworxVolume

portworxVolume represents a portworx volume attached and mounted on kubelets host machine

=cut

k8s projected => 'Core::V1::ProjectedVolumeSource';

=attr projected

projected items for all in one resources secrets, configmaps, and downward API

=cut

k8s quobyte => 'Core::V1::QuobyteVolumeSource';

=attr quobyte

quobyte represents a Quobyte mount on the host that shares a pod's lifetime

=cut

k8s rbd => 'Core::V1::RBDVolumeSource';

=attr rbd

rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md

=cut

k8s scaleIO => 'Core::V1::ScaleIOVolumeSource';

=attr scaleIO

scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.

=cut

k8s secret => 'Core::V1::SecretVolumeSource';

=attr secret

secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret

=cut

k8s storageos => 'Core::V1::StorageOSVolumeSource';

=attr storageos

storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.

=cut

k8s vsphereVolume => 'Core::V1::VsphereVirtualDiskVolumeSource';

=attr vsphereVolume

vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine

=cut

1;
