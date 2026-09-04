package IO::K8s::ExternalSecrets::V1::SenhaseguraProvider;
# ABSTRACT: Senhasegura configures this store to sync secrets using senhasegura provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth                 => '+IO::K8s::ExternalSecrets::V1::SenhaseguraAuth', { required => 'schema' };
k8s ignoreSslCertificate => Bool, { default => 0 };
k8s module               => Str, { required => 'schema' };
k8s url                  => Str, { required => 'schema' };

=attr auth

Auth defines parameters to authenticate in senhasegura

=cut

=attr ignoreSslCertificate

IgnoreSslCertificate defines if SSL certificate must be ignored

=cut

=attr module

Module defines which senhasegura module should be used to get secrets

=cut

=attr url

URL of senhasegura

=cut

1;
