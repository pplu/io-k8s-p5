package IO::K8s::ExternalSecrets::V1::ExternalSecretRewrite;
# ABSTRACT: ExternalSecretRewrite defines how to rewrite secret data values before they are written to the Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s merge     => '+IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteMerge';
k8s regexp    => '+IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteRegexp';
k8s transform => '+IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteTransform';

=attr merge

Used to merge key/values in one single Secret
The resulting key will contain all values from the specified secrets

=cut

=attr regexp

Used to rewrite with regular expressions.
The resulting key will be the output of a regexp.ReplaceAll operation.

=cut

=attr transform

Used to apply string transformation on the secrets.
The resulting key will be the output of the template applied by the operation.

=cut

1;
