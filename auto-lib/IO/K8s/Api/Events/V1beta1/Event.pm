package IO::K8s::Api::Events::V1beta1::Event;
  use Moose;
  use IO::K8s;

  has 'action' => (is => 'ro', isa => 'Str'  );
  has 'apiVersion' => (is => 'ro', isa => 'Str'  );
  has 'deprecatedCount' => (is => 'ro', isa => 'Int'  );
  has 'deprecatedFirstTimestamp' => (is => 'ro', isa => 'Str'  );
  has 'deprecatedLastTimestamp' => (is => 'ro', isa => 'Str'  );
  has 'deprecatedSource' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::EventSource'  );
  has 'eventTime' => (is => 'ro', isa => 'Str'  );
  has 'kind' => (is => 'ro', isa => 'Str'  );
  has 'metadata' => (is => 'ro', isa => 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta'  );
  has 'note' => (is => 'ro', isa => 'Str'  );
  has 'reason' => (is => 'ro', isa => 'Str'  );
  has 'regarding' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ObjectReference'  );
  has 'related' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::ObjectReference'  );
  has 'reportingController' => (is => 'ro', isa => 'Str'  );
  has 'reportingInstance' => (is => 'ro', isa => 'Str'  );
  has 'series' => (is => 'ro', isa => 'IO::K8s::Api::Events::V1beta1::EventSeries'  );
  has 'type' => (is => 'ro', isa => 'Str'  );

  sub to_json { IO::K8s->new->object_to_json(shift) }
1;
