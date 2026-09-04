package IO::K8s::ExternalSecrets::V1::GitlabProvider;
# ABSTRACT: GitLab configures this store to sync secrets using GitLab Variables provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth              => '+IO::K8s::ExternalSecrets::V1::GitlabAuth', { required => 'schema' };
k8s caBundle          => Str;
k8s caProvider        => '+IO::K8s::ExternalSecrets::V1::CAProvider';
k8s environment       => Str;
k8s groupIDs          => [Str];
k8s inheritFromGroups => Bool;
k8s projectID         => Str;
k8s url               => Str;

=attr auth

Auth configures how secret-manager authenticates with a GitLab instance.

=cut

=attr caBundle

Base64 encoded certificate for the GitLab server sdk. The sdk MUST run with HTTPS to make sure no MITM attack
can be performed.

=cut

=attr caProvider

see: https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider

=cut

=attr environment

Environment environment_scope of gitlab CI/CD variables (Please see https://docs.gitlab.com/ee/ci/environments/#create-a-static-environment on how to create environments)

=cut

=attr groupIDs

GroupIDs specify, which gitlab groups to pull secrets from. Group secrets are read from left to right followed by the project variables.

=cut

=attr inheritFromGroups

InheritFromGroups specifies whether parent groups should be discovered and checked for secrets.

=cut

=attr projectID

ProjectID specifies a project where secrets are located.

=cut

=attr url

URL configures the GitLab instance URL. Defaults to https://gitlab.com/.

=cut

1;
