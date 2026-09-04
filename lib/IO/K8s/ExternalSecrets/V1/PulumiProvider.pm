package IO::K8s::ExternalSecrets::V1::PulumiProvider;
# ABSTRACT: Pulumi configures this store to sync secrets using the Pulumi provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessToken  => '+IO::K8s::ExternalSecrets::V1::PulumiProviderSecretRef';
k8s apiUrl       => Str, { default => 'https://api.pulumi.com/api/esc' };
k8s auth         => '+IO::K8s::ExternalSecrets::V1::PulumiAuth';
k8s environment  => Str, { required => 'schema' };
k8s organization => Str, { required => 'schema' };
k8s project      => Str, { required => 'schema' };

=attr accessToken

AccessToken is the access tokens to sign in to the Pulumi Cloud Console.

Deprecated: Use auth.accessToken instead.

=cut

=attr apiUrl

APIURL is the URL of the Pulumi API.

=cut

=attr auth

Auth configures how the Operator authenticates with the Pulumi API.
Either auth or the deprecated accessToken field must be specified.

=cut

=attr environment

Environment are YAML documents composed of static key-value pairs, programmatic expressions,
dynamically retrieved values from supported providers including all major clouds,
and other Pulumi ESC environments.
To create a new environment, visit https://www.pulumi.com/docs/esc/environments/ for more information.

=cut

=attr organization

Organization are a space to collaborate on shared projects and stacks.
To create a new organization, visit https://app.pulumi.com/ and click "New Organization".

=cut

=attr project

Project is the name of the Pulumi ESC project the environment belongs to.

=cut

1;
