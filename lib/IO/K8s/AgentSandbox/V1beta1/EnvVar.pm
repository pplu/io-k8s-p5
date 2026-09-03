package IO::K8s::AgentSandbox::V1beta1::EnvVar;
# ABSTRACT: EnvVar
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s containerName => Str;
k8s name          => Str, { required => 'schema' };
k8s value         => Str, { required => 'schema' };

=attr containerName

No description in the upstream schema.

=cut

=attr name

No description in the upstream schema.

=cut

=attr value

No description in the upstream schema.

=cut

1;
