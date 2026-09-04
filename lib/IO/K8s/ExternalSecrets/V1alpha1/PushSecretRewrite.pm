package IO::K8s::ExternalSecrets::V1alpha1::PushSecretRewrite;
# ABSTRACT: PushSecretRewrite defines how to transform secret keys before pushing.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s regexp    => '+IO::K8s::ExternalSecrets::V1alpha1::ExternalSecretRewriteRegexp';
k8s transform => '+IO::K8s::ExternalSecrets::V1alpha1::ExternalSecretRewriteTransform';

=attr regexp

Used to rewrite with regular expressions.

=cut

=attr transform

Used to apply string transformation on the secrets.

=cut

1;
