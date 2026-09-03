package IO::K8s::CertManager::V1::ServiceAccountRef;
# ABSTRACT: A reference to a service account that will be used to request a bound token (also known as "projected token").
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s audiences => [Str];
k8s name      => Str, { required => 'schema' };

=attr audiences

TokenAudiences is an optional list of audiences to include in the
token passed to AWS. The default token consisting of the issuer's namespace
and name is always included.
If unset the audience defaults to `sts.amazonaws.com`.

=cut

=attr name

Name of the ServiceAccount used to request a token.

=cut

1;
