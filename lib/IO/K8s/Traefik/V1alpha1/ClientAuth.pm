package IO::K8s::Traefik::V1alpha1::ClientAuth;
# ABSTRACT: ClientAuth defines the server's policy for TLS Client Authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientAuthType => Str, { enum => [qw(NoClientCert RequestClientCert RequireAnyClientCert VerifyClientCertIfGiven RequireAndVerifyClientCert)] };
k8s secretNames    => [Str];

=attr clientAuthType

ClientAuthType defines the client authentication type to apply.

=cut

=attr secretNames

SecretNames defines the names of the referenced Kubernetes Secret storing certificate details.

=cut

1;
