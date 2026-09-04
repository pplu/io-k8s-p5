package IO::K8s::ExternalSecrets::V1::FakeProviderData;
# ABSTRACT: FakeProviderData defines a key-value pair with optional version for the fake provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key     => Str, { required => 'schema' };
k8s value   => Str, { required => 'schema' };
k8s version => Str;

=attr key

No description in the upstream schema.

=cut

=attr value

No description in the upstream schema.

=cut

=attr version

No description in the upstream schema.

=cut

1;
