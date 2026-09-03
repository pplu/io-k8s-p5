package IO::K8s::Cilium::V2::HeaderMatch;
# ABSTRACT: HeaderMatch extends the HeaderValue for matching requirement of a named header field against an immediate string or a secret value.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mismatch => Str, { enum => [qw(LOG ADD DELETE REPLACE)] };
k8s name     => Str, { required => 'schema' };
k8s secret   => 'Core::V1::SecretReference';
k8s value    => Str;

=attr mismatch

Mismatch identifies what to do in case there is no match. The default is
to drop the request. Otherwise the overall rule is still considered as
matching, but the mismatches are logged in the access log.

=cut

=attr name

Name identifies the header.

=cut

=attr secret

Secret refers to a secret that contains the value to be matched against.
The secret must only contain one entry. If the referred secret does not
exist, and there is no "Value" specified, the match will fail.

=cut

=attr value

Value matches the exact value of the header. Can be specified either
alone or together with "Secret"; will be used as the header value if the
secret can not be found in the latter case.

=cut

1;
