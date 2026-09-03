package IO::K8s::CertManager::V1::JKSKeystore;
# ABSTRACT: JKS configures options for storing a JKS keystore in the `spec.secretName` Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alias             => Str;
k8s create            => Bool, { required => 'schema' };
k8s password          => Str;
k8s passwordSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';

=attr alias

Alias specifies the alias of the key in the keystore, required by the JKS format.
If not provided, the default alias `certificate` will be used.

=cut

=attr create

Create enables JKS keystore creation for the Certificate.
If true, a file named `keystore.jks` will be created in the target
Secret resource, encrypted using the password stored in
`passwordSecretRef` or `password`.
The keystore file will be updated immediately.
If the issuer provided a CA certificate, a file named `truststore.jks`
will also be created in the target Secret resource, encrypted using the
password stored in `passwordSecretRef`
containing the issuing Certificate Authority

=cut

=attr password

Password provides a literal password used to encrypt the JKS keystore.
Mutually exclusive with passwordSecretRef.
One of password or passwordSecretRef must provide a password with a non-zero length.

=cut

=attr passwordSecretRef

PasswordSecretRef is a reference to a non-empty key in a Secret resource
containing the password used to encrypt the JKS keystore.
Mutually exclusive with password.
One of password or passwordSecretRef must provide a password with a non-zero length.

=cut

1;
