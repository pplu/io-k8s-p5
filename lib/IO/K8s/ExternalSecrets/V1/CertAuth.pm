package IO::K8s::ExternalSecrets::V1::CertAuth;
# ABSTRACT: has both clientCert and clientKey as secretKeySelector
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientCert => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s clientKey  => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr clientCert

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr clientKey

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
