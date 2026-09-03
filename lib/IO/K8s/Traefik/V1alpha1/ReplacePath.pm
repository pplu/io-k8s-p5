package IO::K8s::Traefik::V1alpha1::ReplacePath;
# ABSTRACT: ReplacePath holds the replace path middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path => Str;

=attr path

Path defines the path to use as replacement in the request URL.

=cut

1;
