package IO::K8s::Cilium::V2alpha1::EncryptionSpec;
# ABSTRACT: EncryptionSpec defines the encryption relevant configuration of a node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key => Int;

=attr key

Key is the index to the key to use for encryption or 0 if encryption is
disabled.

=cut

1;
