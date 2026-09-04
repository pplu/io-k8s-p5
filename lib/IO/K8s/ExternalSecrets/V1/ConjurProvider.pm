package IO::K8s::ExternalSecrets::V1::ConjurProvider;
# ABSTRACT: Conjur configures this store to sync secrets using conjur provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::ConjurAuth', { required => 'schema' };
k8s caBundle   => Str;
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s url        => Str, { required => 'schema' };

=attr auth

Defines authentication settings for connecting to Conjur.

=cut

=attr caBundle

CABundle is a PEM encoded CA bundle that will be used to validate the Conjur server certificate.

=cut

=attr caProvider

Used to provide custom certificate authority (CA) certificates
for a secret store. The CAProvider points to a Secret or ConfigMap resource
that contains a PEM-encoded certificate.

=cut

=attr url

URL is the endpoint of the Conjur instance.

=cut

1;
