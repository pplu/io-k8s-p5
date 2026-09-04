package IO::K8s::ExternalSecrets::V1alpha1::PushSecretSelector;
# ABSTRACT: The Secret Selector (k8s source) for the Push Secret
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s generatorRef => 'Autoscaling::V1::CrossVersionObjectReference';
k8s secret       => 'Autoscaling::V2::MetricIdentifier';

=attr generatorRef

Point to a generator to create a Secret.

=cut

=attr secret

Select a Secret to Push.

=cut

1;
