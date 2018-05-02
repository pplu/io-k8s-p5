package IO::K8s::Kubernetes::Pkg::Apis::Policy::V1beta1::PodDisruptionBudgetStatus;
  use Moose;

  has 'desiredHealthy' => (is => 'ro', isa => 'Int'  );
  has 'observedGeneration' => (is => 'ro', isa => 'Int'  );
  has 'expectedPods' => (is => 'ro', isa => 'Int'  );
  has 'disruptedPods' => (is => 'ro', isa => 'HashRef[IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::Time]'  );
  has 'disruptionsAllowed' => (is => 'ro', isa => 'Int'  );
  has 'currentHealthy' => (is => 'ro', isa => 'Int'  );
1;