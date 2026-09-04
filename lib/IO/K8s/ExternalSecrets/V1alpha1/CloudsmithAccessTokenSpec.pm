package IO::K8s::ExternalSecrets::V1alpha1::CloudsmithAccessTokenSpec;
# ABSTRACT: CloudsmithAccessTokenSpec defines the configuration for generating a Cloudsmith access token using OIDC authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiUrl            => Str;
k8s orgSlug           => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };
k8s serviceSlug       => Str, { required => 'schema' };

=attr apiUrl

APIURL configures the Cloudsmith API URL. Defaults to https://api.cloudsmith.io.

=cut

=attr orgSlug

OrgSlug is the organization slug in Cloudsmith

=cut

=attr serviceAccountRef

Name of the service account you are federating with

=cut

=attr serviceSlug

ServiceSlug is the service slug in Cloudsmith for OIDC authentication

=cut

1;
