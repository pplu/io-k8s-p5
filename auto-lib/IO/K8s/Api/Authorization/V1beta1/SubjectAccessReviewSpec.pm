package IO::K8s::Api::Authorization::V1beta1::SubjectAccessReviewSpec;
  use Moose;

  has 'user' => (is => 'ro', isa => 'Str'  );
  has 'uid' => (is => 'ro', isa => 'Str'  );
  has 'nonResourceAttributes' => (is => 'ro', isa => 'IO::K8s::Api::Authorization::V1beta1::NonResourceAttributes'  );
  has 'extra' => (is => 'ro', isa => 'HashRef[ArrayRef[Str]]'  );
  has 'resourceAttributes' => (is => 'ro', isa => 'IO::K8s::Api::Authorization::V1beta1::ResourceAttributes'  );
  has 'group' => (is => 'ro', isa => 'ArrayRef[Str]'  );
1;