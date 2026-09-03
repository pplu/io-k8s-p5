package IO::K8s::Traefik::V1alpha1::AddPrefix;
# ABSTRACT: AddPrefix holds the add prefix middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s prefix => Str;

=attr prefix

Prefix is the string to add before the current path in the requested URL.
It should include a leading slash (/).

=cut

1;
