package IO::K8s::ExternalSecrets::V1::ExternalSecretRewriteRegexp;
# ABSTRACT: Used to rewrite with regular expressions.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s source => Str, { required => 'schema' };
k8s target => Str, { required => 'schema' };

=attr source

Used to define the regular expression of a re.Compiler.

=cut

=attr target

Used to define the target pattern of a ReplaceAll operation.

=cut

1;
