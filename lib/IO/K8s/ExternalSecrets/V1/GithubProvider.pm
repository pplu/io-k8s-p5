package IO::K8s::ExternalSecrets::V1::GithubProvider;
# ABSTRACT: Github configures this store to push GitHub Actions or Dependabot secrets using the GitHub API provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appID               => Int, { required => 'schema' };
k8s auth                => '+IO::K8s::ExternalSecrets::V1::GithubAppAuth', { required => 'schema' };
k8s environment         => Str;
k8s installationID      => Int, { required => 'schema' };
k8s orgSecretVisibility => Str, { enum => [qw(all private)] };
k8s organization        => Str, { required => 'schema' };
k8s repository          => Str;
k8s secretType          => Str, { enum => [qw(Actions Dependabot)], default => 'Actions' };
k8s uploadURL           => Str;
k8s url                 => Str, { default => 'https://github.com/' };

=attr appID

appID specifies the Github APP that will be used to authenticate the client

=cut

=attr auth

auth configures how secret-manager authenticates with a Github instance.

=cut

=attr environment

environment will be used to fetch secrets from a particular environment within a github repository

=cut

=attr installationID

installationID specifies the Github APP installation that will be used to authenticate the client

=cut

=attr orgSecretVisibility

orgSecretVisibility controls the visibility of organization secrets pushed via PushSecret.
Valid values are "all" or "private".
When unset, new secrets are created with visibility "all" and existing secrets preserve
whatever visibility they already have in GitHub.

=cut

=attr organization

organization will be used to fetch secrets from the Github organization

=cut

=attr repository

repository will be used to fetch secrets from the Github repository within an organization

=cut

=attr secretType

secretType specifies which GitHub secret service to use.
Defaults to Actions for backwards compatibility.

=cut

=attr uploadURL

Upload URL for enterprise instances. Default to URL.

=cut

=attr url

URL configures the Github instance URL. Defaults to https://github.com/.

=cut

1;
