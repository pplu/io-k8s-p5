package IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataToMatch;
# ABSTRACT: Match pattern for selecting keys from the source Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s regexp => Str;

=attr regexp

Regexp matches keys by regular expression.
If not specified, all keys are matched.

=cut

1;
