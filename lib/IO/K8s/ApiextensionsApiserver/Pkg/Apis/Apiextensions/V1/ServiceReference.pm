package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::ServiceReference;
# ABSTRACT: ServiceReference holds a reference to Service.legacy.k8s.io
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name is the name of the service. Required

=cut

k8s namespace => Str, 'required';

=attr namespace

namespace is the namespace of the service. Required

=cut

k8s path => Str;

=attr path

path is an optional URL path at which the webhook will be contacted.

=cut

k8s port => Int;

=attr port

port is an optional service port at which the webhook will be contacted. `port` should be a valid port number (1-65535, inclusive). Defaults to 443 for backward compatibility.

=cut

1;
