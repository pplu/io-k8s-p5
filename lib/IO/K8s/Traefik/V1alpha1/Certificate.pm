package IO::K8s::Traefik::V1alpha1::Certificate;
# ABSTRACT: DefaultCertificate defines the default certificate configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretName => Str, { required => 'schema' };

=attr secretName

SecretName is the name of the referenced Kubernetes Secret to specify the certificate details.

=cut

1;
