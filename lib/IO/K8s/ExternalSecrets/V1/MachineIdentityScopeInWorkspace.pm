package IO::K8s::ExternalSecrets::V1::MachineIdentityScopeInWorkspace;
# ABSTRACT: SecretsScope defines the scope of the secrets within the workspace
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s environmentSlug        => Str, { required => 'schema' };
k8s expandSecretReferences => Bool, { default => 1 };
k8s organizationSlug       => Str;
k8s projectSlug            => Str, { required => 'schema' };
k8s recursive              => Bool, { default => 0 };
k8s secretsPath            => Str, { default => '/' };

=attr environmentSlug

EnvironmentSlug is the required slug identifier for the environment.

=cut

=attr expandSecretReferences

ExpandSecretReferences indicates whether secret references should be expanded. Defaults to true if not provided.

=cut

=attr organizationSlug

OrganizationSlug is the optional slug that identifies the organization that will be used
during authentication. Useful for sub-organization setups

=cut

=attr projectSlug

ProjectSlug is the required slug identifier for the project.

=cut

=attr recursive

Recursive indicates whether the secrets should be fetched recursively. Defaults to false if not provided.

=cut

=attr secretsPath

SecretsPath specifies the path to the secrets within the workspace. Defaults to "/" if not provided.

=cut

1;
