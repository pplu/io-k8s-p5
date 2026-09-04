package IO::K8s::ExternalSecrets::V1::BeyondtrustServer;
# ABSTRACT: Auth configures how API server works.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiUrl               => Str, { required => 'schema' };
k8s apiVersion           => Str;
k8s clientTimeOutSeconds => Int;
k8s decrypt              => Bool, { default => 1 };
k8s retrievalType        => Str;
k8s separator            => Str;
k8s verifyCA             => Bool, { required => 'schema' };

=attr apiUrl

No description in the upstream schema.

=cut

=attr apiVersion

No description in the upstream schema.

=cut

=attr clientTimeOutSeconds

Timeout specifies a time limit for requests made by this Client. The timeout includes connection time, any redirects, and reading the response body. Defaults to 45 seconds.

=cut

=attr decrypt

When true, the response includes the decrypted password. When false, the password field is omitted. This option only applies to the SECRET retrieval type. Default: true.

=cut

=attr retrievalType

The secret retrieval type. SECRET = Secrets Safe (credential, text, file). MANAGED_ACCOUNT = Password Safe account associated with a system.

=cut

=attr separator

A character that separates the folder names.

=cut

=attr verifyCA

No description in the upstream schema.

=cut

1;
