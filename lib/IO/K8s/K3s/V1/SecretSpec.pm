package IO::K8s::K3s::V1::SecretSpec;
# ABSTRACT: SecretSpec describes a key in a secret to load chart values from.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ignoreUpdates => Bool;
k8s keys          => [Str];
k8s name          => Str;

=attr ignoreUpdates

Ignore changes to the secret, and mark the secret as optional.
By default, the secret must exist, and changes to the secret will trigger an upgrade of the chart to apply the updated values.
If `ignoreUpdates` is true, the secret is optional, and changes to the secret will not trigger an upgrade of the chart.

=cut

=attr keys

Keys to read values content from. If no keys are specified, the secret is not used.

=cut

=attr name

Name of the secret. Must be in the same namespace as the HelmChart resource.

=cut

1;
