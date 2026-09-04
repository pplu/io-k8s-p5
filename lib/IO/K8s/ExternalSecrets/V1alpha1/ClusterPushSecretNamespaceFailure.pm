package IO::K8s::ExternalSecrets::V1alpha1::ClusterPushSecretNamespaceFailure;
# ABSTRACT: ClusterPushSecretNamespaceFailure represents a failed namespace deployment and it's reason.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespace => Str, { required => 'schema' };
k8s reason    => Str;

=attr namespace

Namespace is the namespace that failed when trying to apply an PushSecret

=cut

=attr reason

Reason is why the PushSecret failed to apply to the namespace

=cut

1;
