package IO::K8s::Api::Apps::V1::StatefulSetSpec;
  use Moose;
  use IO::K8s;

  has 'podManagementPolicy' => (is => 'ro', isa => 'Str'  );
  has 'replicas' => (is => 'ro', isa => 'Int'  );
  has 'revisionHistoryLimit' => (is => 'ro', isa => 'Int'  );
  has 'selector' => (is => 'ro', isa => 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector'  );
  has 'serviceName' => (is => 'ro', isa => 'Str'  );
  has 'template' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PodTemplateSpec'  );
  has 'updateStrategy' => (is => 'ro', isa => 'IO::K8s::Api::Apps::V1::StatefulSetUpdateStrategy'  );
  has 'volumeClaimTemplates' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::PersistentVolumeClaim]'  );

  sub to_json { IO::K8s->new->object_to_json(shift) }
1;
