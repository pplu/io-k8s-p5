package IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployTokenSpec;
# ABSTRACT: GitlabDeployTokenSpec defines the desired state to generate a GitLab deploy token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1alpha1::GitlabTokenAuth', { required => 'schema' };
k8s expiresAt => Time;
k8s groupID   => Str;
k8s name      => Str, { required => 'schema' };
k8s projectID => Str;
k8s scopes    => [Str], { required => 'schema', enum => [qw(read_repository read_registry write_registry read_package_registry write_package_registry read_virtual_registry write_virtual_registry)] };
k8s url       => Str;
k8s username  => Str;

=attr auth

Auth configures how ESO authenticates with the GitLab API.

=cut

=attr expiresAt

ExpiresAt is an optional expiry for the deploy token. If omitted the token does
not expire on the GitLab side and is revoked only when the generator state is
cleaned up (on regeneration or when the consuming ExternalSecret is deleted).

=cut

=attr groupID

GroupID is the numeric ID or unescaped path (e.g. parent/group) of the group to
create the deploy token in. The generator URL-escapes paths before calling the
GitLab API, so do not pre-encode. Mutually exclusive with projectID.

=cut

=attr name

Name of the deploy token.

=cut

=attr projectID

ProjectID is the numeric ID or unescaped path (e.g. group/project) of the
project to create the deploy token in. The generator URL-escapes paths before
calling the GitLab API, so do not pre-encode. Mutually exclusive with groupID.

=cut

=attr scopes

Scopes granted to the deploy token. At least one scope is required.

=cut

=attr url

URL configures the GitLab instance URL. Defaults to https://gitlab.com.

=cut

=attr username

Username is an optional username for the deploy token. GitLab defaults it to
gitlab+deploy-token-{n} when omitted.

=cut

1;
