package IO::K8s::ExternalSecrets::V1::IBMAuthContainerAuth;
# ABSTRACT: IBMAuthContainerAuth defines container-based authentication with IAM Trusted Profile.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s iamEndpoint   => Str;
k8s profile       => Str, { required => 'schema' };
k8s tokenLocation => Str;

=attr iamEndpoint

No description in the upstream schema.

=cut

=attr profile

the IBM Trusted Profile

=cut

=attr tokenLocation

Location the token is mounted on the pod

=cut

1;
