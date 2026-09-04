package IO::K8s::ExternalSecrets::V1::VolcengineProvider;
# ABSTRACT: Volcengine configures this store to sync secrets using the Volcengine provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth   => '+IO::K8s::ExternalSecrets::V1::VolcengineAuth';
k8s region => Str, { required => 'schema' };

=attr auth

Auth defines the authentication method to use.
If not specified, the provider will try to use IRSA (IAM Role for Service Account).

=cut

=attr region

Region specifies the Volcengine region to connect to.

=cut

1;
