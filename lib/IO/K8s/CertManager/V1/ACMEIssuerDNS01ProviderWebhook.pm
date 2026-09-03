package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderWebhook;
# ABSTRACT: Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s config     => Str, { preserve_unknown => 1 };
k8s groupName  => Str, { required => 'schema' };
k8s solverName => Str, { required => 'schema' };

=attr config

Additional configuration that should be passed to the webhook apiserver
when challenges are processed.
This can contain arbitrary JSON data.
Secret values should not be specified in this stanza.
If secret values are needed (e.g., credentials for a DNS service), you
should use a SecretKeySelector to reference a Secret resource.
For details on the schema of this field, consult the webhook provider
implementation's documentation.

=cut

=attr groupName

The API group name that should be used when POSTing ChallengePayload
resources to the webhook apiserver.
This should be the same as the GroupName specified in the webhook
provider implementation.

=cut

=attr solverName

The name of the solver to use, as defined in the webhook provider
implementation.
This will typically be the name of the provider, e.g., 'cloudflare'.

=cut

1;
