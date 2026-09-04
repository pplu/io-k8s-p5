package IO::K8s::ExternalSecrets::V1::Tag;
# ABSTRACT: Tag is a key-value pair that can be attached to an AWS resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key   => Str, { required => 'schema' };
k8s value => Str, { required => 'schema' };

=attr key

No description in the upstream schema.

=cut

=attr value

No description in the upstream schema.

=cut

1;
