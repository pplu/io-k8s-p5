package IO::K8s::ExternalSecrets::V1::CRDProviderWhitelistRule;
# ABSTRACT: CRDProviderWhitelistRule defines a single allow rule for CRD reads.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name       => Str;
k8s namespace  => Str;
k8s properties => [Str];

=attr name

Name is an optional regular expression matched against the bare object name.
For both SecretStore and ClusterSecretStore this is always the object name
without any namespace prefix (e.g. "my-db-spec", not "prod/my-db-spec").

=cut

=attr namespace

Namespace is an optional regular expression matched against the namespace of
the object. Applies only when a ClusterSecretStore is used; it is ignored
for SecretStore (where the namespace is fixed to the store namespace).

=cut

=attr properties

Properties is an optional list of regular expressions matched against
requested property keys (for example: "spec.secretValue").

=cut

1;
