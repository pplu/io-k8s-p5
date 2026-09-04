package IO::K8s::ExternalSecrets::V1alpha1::SSHKeySpec;
# ABSTRACT: SSHKeySpec controls the behavior of the ssh key generator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s comment => Str;
k8s keySize => Int, { minimum => 256, maximum => 8192 };
k8s keyType => Str, { enum => [qw(rsa ecdsa ed25519)], default => 'rsa' };

=attr comment

Comment specifies an optional comment for the SSH key

=cut

=attr keySize

KeySize specifies the key size for RSA keys (default: 2048) and ECDSA keys (default: 256).
For RSA keys: 2048, 3072, 4096
For ECDSA keys: 256, 384, 521
Ignored for ed25519 keys

=cut

=attr keyType

KeyType specifies the SSH key type (rsa, ecdsa, ed25519)

=cut

1;
