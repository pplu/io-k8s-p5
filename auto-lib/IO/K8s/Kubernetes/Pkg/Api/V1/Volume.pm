package IO::K8s::Kubernetes::Pkg::Api::V1::Volume;
  use Moose;

  has 'azureDisk' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::AzureDiskVolumeSource'  );
  has 'cinder' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::CinderVolumeSource'  );
  has 'projected' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ProjectedVolumeSource'  );
  has 'hostPath' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::HostPathVolumeSource'  );
  has 'photonPersistentDisk' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PhotonPersistentDiskVolumeSource'  );
  has 'flexVolume' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::FlexVolumeSource'  );
  has 'gitRepo' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::GitRepoVolumeSource'  );
  has 'name' => (is => 'ro', isa => 'Str'  );
  has 'scaleIO' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ScaleIOVolumeSource'  );
  has 'fc' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::FCVolumeSource'  );
  has 'cephfs' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::CephFSVolumeSource'  );
  has 'flocker' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::FlockerVolumeSource'  );
  has 'vsphereVolume' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::VsphereVirtualDiskVolumeSource'  );
  has 'downwardAPI' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::DownwardAPIVolumeSource'  );
  has 'quobyte' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::QuobyteVolumeSource'  );
  has 'persistentVolumeClaim' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PersistentVolumeClaimVolumeSource'  );
  has 'rbd' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::RBDVolumeSource'  );
  has 'secret' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::SecretVolumeSource'  );
  has 'emptyDir' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::EmptyDirVolumeSource'  );
  has 'awsElasticBlockStore' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::AWSElasticBlockStoreVolumeSource'  );
  has 'nfs' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::NFSVolumeSource'  );
  has 'azureFile' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::AzureFileVolumeSource'  );
  has 'configMap' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ConfigMapVolumeSource'  );
  has 'storageos' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::StorageOSVolumeSource'  );
  has 'iscsi' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ISCSIVolumeSource'  );
  has 'portworxVolume' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PortworxVolumeSource'  );
  has 'glusterfs' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::GlusterfsVolumeSource'  );
  has 'gcePersistentDisk' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::GCEPersistentDiskVolumeSource'  );
1;