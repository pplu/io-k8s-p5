package IO::K8s::ExternalSecrets::V1::AkeylessAuthSecretRef;
# ABSTRACT: Reference to a Secret that contains the details to authenticate with Akeyless.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessID        => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s accessType      => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s accessTypeParam => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr accessID

The SecretAccessID is used for authentication

=cut

=attr accessType

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr accessTypeParam

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
