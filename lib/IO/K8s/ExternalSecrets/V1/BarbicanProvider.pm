package IO::K8s::ExternalSecrets::V1::BarbicanProvider;
# ABSTRACT: Barbican configures this store to sync secrets using the OpenStack Barbican provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::BarbicanAuth', { required => 'schema' };
k8s authURL    => Str;
k8s domainName => Str;
k8s region     => Str;
k8s tenantName => Str;

=attr auth

BarbicanAuth contains the authentication information for Barbican.

=cut

=attr authURL

No description in the upstream schema.

=cut

=attr domainName

No description in the upstream schema.

=cut

=attr region

No description in the upstream schema.

=cut

=attr tenantName

No description in the upstream schema.

=cut

1;
