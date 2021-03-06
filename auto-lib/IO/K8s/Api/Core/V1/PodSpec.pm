package IO::K8s::Api::Core::V1::PodSpec;
  use Moose;
  use IO::K8s;

  has 'activeDeadlineSeconds' => (is => 'ro', isa => 'Int'  );
  has 'affinity' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::Affinity'  );
  has 'automountServiceAccountToken' => (is => 'ro', isa => 'Bool'  );
  has 'containers' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::Container]'  );
  has 'dnsConfig' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PodDNSConfig'  );
  has 'dnsPolicy' => (is => 'ro', isa => 'Str'  );
  has 'enableServiceLinks' => (is => 'ro', isa => 'Bool'  );
  has 'hostAliases' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::HostAlias]'  );
  has 'hostIPC' => (is => 'ro', isa => 'Bool'  );
  has 'hostname' => (is => 'ro', isa => 'Str'  );
  has 'hostNetwork' => (is => 'ro', isa => 'Bool'  );
  has 'hostPID' => (is => 'ro', isa => 'Bool'  );
  has 'imagePullSecrets' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::LocalObjectReference]'  );
  has 'initContainers' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::Container]'  );
  has 'nodeName' => (is => 'ro', isa => 'Str'  );
  has 'nodeSelector' => (is => 'ro', isa => 'HashRef[Str]'  );
  has 'priority' => (is => 'ro', isa => 'Int'  );
  has 'priorityClassName' => (is => 'ro', isa => 'Str'  );
  has 'readinessGates' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::PodReadinessGate]'  );
  has 'restartPolicy' => (is => 'ro', isa => 'Str'  );
  has 'runtimeClassName' => (is => 'ro', isa => 'Str'  );
  has 'schedulerName' => (is => 'ro', isa => 'Str'  );
  has 'securityContext' => (is => 'ro', isa => 'IO::K8s::Api::Core::V1::PodSecurityContext'  );
  has 'serviceAccount' => (is => 'ro', isa => 'Str'  );
  has 'serviceAccountName' => (is => 'ro', isa => 'Str'  );
  has 'shareProcessNamespace' => (is => 'ro', isa => 'Bool'  );
  has 'subdomain' => (is => 'ro', isa => 'Str'  );
  has 'terminationGracePeriodSeconds' => (is => 'ro', isa => 'Int'  );
  has 'tolerations' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::Toleration]'  );
  has 'volumes' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Core::V1::Volume]'  );

  sub to_json { IO::K8s->new->object_to_json(shift) }
1;
