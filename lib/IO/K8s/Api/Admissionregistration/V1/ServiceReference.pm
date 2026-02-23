package IO::K8s::Api::Admissionregistration::V1::ServiceReference;
# ABSTRACT: ServiceReference holds a reference to Service.legacy.k8s.io
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

`name` is the name of the service. Required

=cut

k8s namespace => Str, 'required';

=attr namespace

`namespace` is the namespace of the service. Required

=cut

k8s path => Str;

=attr path

`path` is an optional URL path which will be sent in any request to this service.

=cut

k8s port => Int;

=attr port

If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).

=cut

1;
