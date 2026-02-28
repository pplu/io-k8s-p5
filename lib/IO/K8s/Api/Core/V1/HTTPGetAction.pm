package IO::K8s::Api::Core::V1::HTTPGetAction;
# ABSTRACT: HTTPGetAction describes an action based on HTTP Get requests.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s host => Str;

=attr host

Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.

=cut

k8s httpHeaders => ['Core::V1::HTTPHeader'];

=attr httpHeaders

Custom headers to set in the request. HTTP allows repeated headers.

=cut

k8s path => Str;

=attr path

Path to access on the HTTP server.

=cut

k8s port => IntOrStr, 'required';

=attr port

Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.

=cut

k8s scheme => Str;

=attr scheme

Scheme to use for connecting to the host. Defaults to HTTP.

=cut

1;
