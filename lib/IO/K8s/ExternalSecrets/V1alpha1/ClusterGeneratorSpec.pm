package IO::K8s::ExternalSecrets::V1alpha1::ClusterGeneratorSpec;
# ABSTRACT: ClusterGeneratorSpec defines the desired state of a ClusterGenerator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s generator => '+IO::K8s::ExternalSecrets::V1alpha1::ClusterGeneratorGenerator', { required => 'schema' };
k8s kind      => Str, { required => 'schema', enum => [qw(
    ACRAccessToken BeyondtrustWorkloadCredentialsDynamicSecret CloudsmithAccessToken
    ECRAuthorizationToken Fake GCRAccessToken GithubAccessToken GitlabDeployToken
    QuayAccessToken Password SSHKey STSSessionToken UUID VaultDynamicSecret Webhook
    Grafana MFA
)] };

=attr generator

Generator the spec for this generator, must match the kind.

Upstream restricts this object to exactly one set member (C<minProperties>/
C<maxProperties> of 1); like every other exclusive-union class in this
distribution (e.g. L<IO::K8s::ExternalSecrets::V1::SecretStoreProvider>), that
cardinality is not a constraint the C<k8s> DSL has a way to express and is not
enforced at construction here.

=cut

=attr kind

Kind the kind of this generator.

=cut

1;
