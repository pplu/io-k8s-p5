package IO::K8s::Api::Core::V1::StorageOSVolumeSource;
  use Moose;
  use IO::K8s;

  has 'fsType' => (is => 'ro', isa => 'Str'  );
  has 'readOnly' => (is => 'ro', isa => 'Bool'  );
  has 'secretRef' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::LocalObjectReference'  );
  has 'volumeName' => (is => 'ro', isa => 'Str'  );
  has 'volumeNamespace' => (is => 'ro', isa => 'Str'  );

  sub to_json { IO::K8s->new->object_to_json(shift) }
1;
