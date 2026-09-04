package IO::K8s::ExternalSecrets::V1::AWSProvider;
# ABSTRACT: AWS configures this store to sync secrets using AWS Secret Manager provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s additionalRoles   => [Str];
k8s auth              => '+IO::K8s::ExternalSecrets::V1::AWSAuth';
k8s customSessionTags => { Str => 1 };
k8s externalID        => Str;
k8s prefix            => Str;
k8s region            => Str, { required => 'schema' };
k8s role              => Str;
k8s secretsManager    => '+IO::K8s::ExternalSecrets::V1::SecretsManager';
k8s service           => Str, { required => 'schema', enum => [qw(SecretsManager ParameterStore CertificateManager)] };
k8s sessionTags       => ['+IO::K8s::ExternalSecrets::V1::Tag'];
k8s sessionTagsPolicy => Str, { enum => [qw(None Simple Custom)], default => 'None' };
k8s transitiveTagKeys => [Str];

=attr additionalRoles

AdditionalRoles is a chained list of Role ARNs which the provider will sequentially assume before assuming the Role

=cut

=attr auth

Auth defines the information necessary to authenticate against AWS
if not set aws sdk will infer credentials from your environment
see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials

=cut

=attr customSessionTags

CustomSessionTags defines additional STS session tags to include when SessionTagsPolicy is Custom.
These are merged with the automatically injected esoNamespace, esoStoreName, and esoStoreKind tags.

=cut

=attr externalID

AWS External ID set on assumed IAM roles

=cut

=attr prefix

Prefix adds a prefix to all retrieved values.

=cut

=attr region

AWS Region to be used for the provider

=cut

=attr role

Role is a Role ARN which the provider will assume

=cut

=attr secretsManager

SecretsManager defines how the provider behaves when interacting with AWS SecretsManager

=cut

=attr service

Service defines which service should be used to fetch the secrets

=cut

=attr sessionTags

AWS STS assume role session tags

=cut

=attr sessionTagsPolicy

SessionTagsPolicy controls whether and how STS session tags are added when assuming roles.
None (default): no tags are added.
Simple: automatically adds esoNamespace (from the ExternalSecret), esoStoreName, and esoStoreKind tags.
Custom: adds esoNamespace, esoStoreName, and esoStoreKind plus any tags defined in CustomSessionTags.
Note: the IAM role must have sts:TagSession permission when using Simple or Custom.

=cut

=attr transitiveTagKeys

AWS STS assume role transitive session tags. Required when multiple rules are used with the provider

=cut

1;
