package IO::K8s::Api::Core::V1::SecretReference;
# ABSTRACT: SecretReference represents a Secret Reference. It has enough information to retrieve secret in any namespace
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s name => Str;

=attr name

name is unique within a namespace to reference a secret resource.

=cut

k8s namespace => Str;

=attr namespace

namespace defines the space within which the secret name must be unique.

=cut

1;
