package IO::K8s::CertManager::V1::CertificateAdditionalOutputFormat;
# ABSTRACT: CertificateAdditionalOutputFormat defines an additional output format of a Certificate resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type => Str, { required => 'schema', enum => [qw(DER CombinedPEM)] };

=attr type

Type is the name of the format type that should be written to the
Certificate's target Secret.

=cut

1;
