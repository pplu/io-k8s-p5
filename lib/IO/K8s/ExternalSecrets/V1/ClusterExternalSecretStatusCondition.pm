package IO::K8s::ExternalSecrets::V1::ClusterExternalSecretStatusCondition;
# ABSTRACT: ClusterExternalSecretStatusCondition defines the observed state of a ClusterExternalSecret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s message => Str;
k8s status  => Str, { required => 'schema' };
k8s type    => Str, { required => 'schema' };

=attr message

No description in the upstream schema.

=cut

=attr status

No description in the upstream schema.

=cut

=attr type

ClusterExternalSecretConditionType defines a value type for ClusterExternalSecret conditions.

=cut

1;
