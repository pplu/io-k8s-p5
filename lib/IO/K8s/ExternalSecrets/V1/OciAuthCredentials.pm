package IO::K8s::ExternalSecrets::V1::OciAuthCredentials;
# ABSTRACT: OciAuthCredentials represents the credentials for OCI authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s fingerprint          => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s identityId           => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s privateKey           => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s privateKeyPassphrase => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s region               => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s tenancyId            => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s userId               => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr fingerprint

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr identityId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr privateKey

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr privateKeyPassphrase

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr region

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr tenancyId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr userId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
