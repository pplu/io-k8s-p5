package IO::K8s::Api::Core::V1::PersistentVolumeSpec;
# ABSTRACT: PersistentVolumeSpec is the specification of a persistent volume.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s accessModes => [Str];

=attr accessModes

accessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes

=cut

k8s awsElasticBlockStore => 'Core::V1::AWSElasticBlockStoreVolumeSource';

=attr awsElasticBlockStore

awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore

=cut

k8s azureDisk => 'Core::V1::AzureDiskVolumeSource';

=attr azureDisk

azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.

=cut

k8s azureFile => 'Core::V1::AzureFilePersistentVolumeSource';

=attr azureFile

azureFile represents an Azure File Service mount on the host and bind mount to the pod.

=cut

k8s capacity => { Str => 1 };

=attr capacity

capacity is the description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity

=cut

k8s cephfs => 'Core::V1::CephFSPersistentVolumeSource';

=attr cephfs

cephFS represents a Ceph FS mount on the host that shares a pod's lifetime

=cut

k8s cinder => 'Core::V1::CinderPersistentVolumeSource';

=attr cinder

cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md

=cut

k8s claimRef => 'Core::V1::ObjectReference';

=attr claimRef

claimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding

=cut

k8s csi => 'Core::V1::CSIPersistentVolumeSource';

=attr csi

csi represents storage that is handled by an external CSI driver (Beta feature).

=cut

k8s fc => 'Core::V1::FCVolumeSource';

=attr fc

fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.

=cut

k8s flexVolume => 'Core::V1::FlexPersistentVolumeSource';

=attr flexVolume

flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.

=cut

k8s flocker => 'Core::V1::FlockerVolumeSource';

=attr flocker

flocker represents a Flocker volume attached to a kubelet's host machine and exposed to the pod for its usage. This depends on the Flocker control service being running

=cut

k8s gcePersistentDisk => 'Core::V1::GCEPersistentDiskVolumeSource';

=attr gcePersistentDisk

gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk

=cut

k8s glusterfs => 'Core::V1::GlusterfsPersistentVolumeSource';

=attr glusterfs

glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://examples.k8s.io/volumes/glusterfs/README.md

=cut

k8s hostPath => 'Core::V1::HostPathVolumeSource';

=attr hostPath

hostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath

=cut

k8s iscsi => 'Core::V1::ISCSIPersistentVolumeSource';

=attr iscsi

iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.

=cut

k8s local => 'Core::V1::LocalVolumeSource';

=attr local

local represents directly-attached storage with node affinity

=cut

k8s mountOptions => [Str];

=attr mountOptions

mountOptions is the list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options

=cut

k8s nfs => 'Core::V1::NFSVolumeSource';

=attr nfs

nfs represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

=cut

k8s nodeAffinity => 'Core::V1::VolumeNodeAffinity';

=attr nodeAffinity

nodeAffinity defines constraints that limit what nodes this volume can be accessed from. This field influences the scheduling of pods that use this volume.

=cut

k8s persistentVolumeReclaimPolicy => Str;

=attr persistentVolumeReclaimPolicy

persistentVolumeReclaimPolicy defines what happens to a persistent volume when released from its claim. Valid options are Retain (default for manually created PersistentVolumes), Delete (default for dynamically provisioned PersistentVolumes), and Recycle (deprecated). Recycle must be supported by the volume plugin underlying this PersistentVolume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#reclaiming

=cut

k8s photonPersistentDisk => 'Core::V1::PhotonPersistentDiskVolumeSource';

=attr photonPersistentDisk

photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine

=cut

k8s portworxVolume => 'Core::V1::PortworxVolumeSource';

=attr portworxVolume

portworxVolume represents a portworx volume attached and mounted on kubelets host machine

=cut

k8s quobyte => 'Core::V1::QuobyteVolumeSource';

=attr quobyte

quobyte represents a Quobyte mount on the host that shares a pod's lifetime

=cut

k8s rbd => 'Core::V1::RBDPersistentVolumeSource';

=attr rbd

rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md

=cut

k8s scaleIO => 'Core::V1::ScaleIOPersistentVolumeSource';

=attr scaleIO

scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.

=cut

k8s storageClassName => Str;

=attr storageClassName

storageClassName is the name of StorageClass to which this persistent volume belongs. Empty value means that this volume does not belong to any StorageClass.

=cut

k8s storageos => 'Core::V1::StorageOSPersistentVolumeSource';

=attr storageos

storageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://examples.k8s.io/volumes/storageos/README.md

=cut

k8s volumeAttributesClassName => Str;

=attr volumeAttributesClassName

Name of VolumeAttributesClass to which this persistent volume belongs. Empty value is not allowed. When this field is not set, it indicates that this volume does not belong to any VolumeAttributesClass. This field is mutable and can be changed by the CSI driver after a volume has been updated successfully to a new class. For an unbound PersistentVolume, the volumeAttributesClassName will be matched with unbound PersistentVolumeClaims during the binding process. This is a beta field and requires enabling VolumeAttributesClass feature (off by default).

=cut

k8s volumeMode => Str;

=attr volumeMode

volumeMode defines if a volume is intended to be used with a formatted filesystem or to remain in raw block state. Value of Filesystem is implied when not included in spec.

=cut

k8s vsphereVolume => 'Core::V1::VsphereVirtualDiskVolumeSource';

=attr vsphereVolume

vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine

=cut

1;
