package IO::K8s::Api::Networking::V1::ServiceBackendPort;
# ABSTRACT: ServiceBackendPort is the service port being referenced.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str;

=attr name

name is the name of the port on the Service. This is a mutually exclusive setting with "Number".

=cut

k8s number => Int;

=attr number

number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with "Name".

=cut

1;
