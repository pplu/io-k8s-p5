package IO::K8s::CertManager::V1::ACMEAuthorization;
# ABSTRACT: ACMEAuthorization contains data returned from the ACME server on an authorization that must be completed in order validate a DNS name on an ACME Order resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s challenges   => ['+IO::K8s::CertManager::V1::ACMEChallenge'];
k8s identifier   => Str;
k8s initialState => Str, { enum => [qw(valid ready pending processing invalid expired errored)] };
k8s url          => Str, { required => 'schema' };
k8s wildcard     => Bool;

=attr challenges

Challenges specifies the challenge types offered by the ACME server.
One of these challenge types will be selected when validating the DNS
name and an appropriate Challenge resource will be created to perform
the ACME challenge process.

=cut

=attr identifier

Identifier is the DNS name to be validated as part of this authorization

=cut

=attr initialState

InitialState is the initial state of the ACME authorization when first
fetched from the ACME server.
If an Authorization is already 'valid', the Order controller will not
create a Challenge resource for the authorization. This will occur when
working with an ACME server that enables 'authz reuse' (such as Let's
Encrypt's production endpoint).
If not set and 'identifier' is set, the state is assumed to be pending
and a Challenge will be created.

=cut

=attr url

URL is the URL of the Authorization that must be completed

=cut

=attr wildcard

Wildcard will be true if this authorization is for a wildcard DNS name.
If this is true, the identifier will be the *non-wildcard* version of
the DNS name.
For example, if '*.example.com' is the DNS name being validated, this
field will be 'true' and the 'identifier' field will be 'example.com'.

=cut

1;
