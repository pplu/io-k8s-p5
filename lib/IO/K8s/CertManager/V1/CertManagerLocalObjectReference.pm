package IO::K8s::CertManager::V1::CertManagerLocalObjectReference;
# ABSTRACT: CredentialsRef is a reference to a Secret containing the CyberArk Certificate Manager Self-Hosted API credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { required => 'schema' };

=attr name

Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

=cut

1;
