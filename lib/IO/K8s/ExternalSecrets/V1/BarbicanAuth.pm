package IO::K8s::ExternalSecrets::V1::BarbicanAuth;
# ABSTRACT: BarbicanAuth contains the authentication information for Barbican.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s password => '+IO::K8s::ExternalSecrets::V1::BarbicanProviderPasswordRef', { required => 'schema' };
k8s username => '+IO::K8s::ExternalSecrets::V1::BarbicanProviderUsernameRef', { required => 'schema' };

=attr password

BarbicanProviderPasswordRef defines a reference to a secret containing password for the Barbican provider.

=cut

=attr username

BarbicanProviderUsernameRef defines a reference to a secret containing username for the Barbican provider.

=cut

1;
