package IO::K8s::Api::Authorization::V1::NonResourceAttributes;
# ABSTRACT: NonResourceAttributes includes the authorization attributes available for non-resource requests to the Authorizer interface
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s path => Str;

=attr path

Path is the URL path of the request

=cut

k8s verb => Str;

=attr verb

Verb is the standard HTTP verb

=cut

1;
