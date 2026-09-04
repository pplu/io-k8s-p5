package IO::K8s::ExternalSecrets::V1alpha1::FakeSpec;
# ABSTRACT: FakeSpec contains the static data.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s controller => Str;
k8s data       => { Str => 1 };

=attr controller

Used to select the correct ESO controller (think: ingress.ingressClassName)
The ESO controller is instantiated with a specific controller name and filters VDS based on this property

=cut

=attr data

Data defines the static data returned
by this generator.

=cut

1;
