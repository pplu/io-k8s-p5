package IO::K8s::Traefik::V1alpha1::Sticky;
# ABSTRACT: Sticky defines the sticky sessions configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cookie => '+IO::K8s::Traefik::V1alpha1::Cookie';

=attr cookie

Cookie defines the sticky cookie configuration.

=cut

1;
