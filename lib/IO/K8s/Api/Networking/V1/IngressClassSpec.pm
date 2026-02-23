package IO::K8s::Api::Networking::V1::IngressClassSpec;
# ABSTRACT: IngressClassSpec provides information about the class of an Ingress.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s controller => Str;

=attr controller

controller refers to the name of the controller that should handle this class. This allows for different "flavors" that are controlled by the same controller. For example, you may have different parameters for the same implementing controller. This should be specified as a domain-prefixed path no more than 250 characters in length, e.g. "acme.io/ingress-controller". This field is immutable.

=cut

k8s parameters => 'Networking::V1::IngressClassParametersReference';

=attr parameters

parameters is a link to a custom resource containing additional configuration for the controller. This is optional if the controller does not require extra parameters.

=cut

1;
