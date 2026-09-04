package IO::K8s::ExternalSecrets::V1::FindName;
# ABSTRACT: Finds secrets based on the name.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s regexp => Str;

=attr regexp

Finds secrets base

=cut

1;
