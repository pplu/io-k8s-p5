package IO::K8s::ExternalSecrets::V1alpha1::GithubAccessTokenSpec;
# ABSTRACT: GithubAccessTokenSpec defines the desired state to generate a GitHub access token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appID        => Str, { required => 'schema' };
k8s auth         => '+IO::K8s::ExternalSecrets::V1alpha1::GithubAuth', { required => 'schema' };
k8s installID    => Str, { required => 'schema' };
k8s permissions  => { Str => 1 };
k8s repositories => [Str];
k8s url          => Str;

=attr appID

No description in the upstream schema.

=cut

=attr auth

Auth configures how ESO authenticates with a Github instance.

=cut

=attr installID

No description in the upstream schema.

=cut

=attr permissions

Map of permissions the token will have. If omitted, defaults to all permissions the GitHub App has.

=cut

=attr repositories

List of repositories the token will have access to. If omitted, defaults to all repositories the GitHub App
is installed to.

=cut

=attr url

URL configures the GitHub instance URL. Defaults to https://github.com/.

=cut

1;
