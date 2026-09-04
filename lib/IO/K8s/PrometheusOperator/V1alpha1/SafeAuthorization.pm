package IO::K8s::PrometheusOperator::V1alpha1::SafeAuthorization;
# ABSTRACT: authorization defines the header configuration to authenticate against the PuppetDB API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s credentials => 'Core::V1::ConfigMapKeySelector';
k8s type        => Str;

=attr credentials

credentials defines a key of a Secret in the namespace that contains the credentials for authentication.

=cut

=attr type

type defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"

=cut

1;
