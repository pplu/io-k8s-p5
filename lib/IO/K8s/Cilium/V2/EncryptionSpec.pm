package IO::K8s::Cilium::V2::EncryptionSpec;
# ABSTRACT: Encryption is the encryption configuration of the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key => Int;

=attr key

Key is the index to the key to use for encryption or 0 if encryption is
disabled.

=cut

1;
