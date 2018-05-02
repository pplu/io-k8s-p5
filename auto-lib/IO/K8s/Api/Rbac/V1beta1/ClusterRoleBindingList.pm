package IO::K8s::Api::Rbac::V1beta1::ClusterRoleBindingList;
  use Moose;

  has 'metadata' => (is => 'ro', isa => 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ListMeta'  );
  has 'kind' => (is => 'ro', isa => 'Str'  );
  has 'items' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Rbac::V1beta1::ClusterRoleBinding]'  );
  has 'apiVersion' => (is => 'ro', isa => 'Str'  );
1;