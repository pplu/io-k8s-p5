package IO::K8s::GatewayAPI::V1beta1::SupportedFeature;
# ABSTRACT: SupportedFeature
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { required => 'schema' };

=attr name

FeatureName is used to describe distinct features that are covered by
conformance tests.

=cut

1;
