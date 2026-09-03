package IO::K8s::Traefik::V1alpha1::FailoverError;
# ABSTRACT: Errors defines which errors should trigger the use of the fallback service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxRequestBodyBytes => Int;
k8s status              => [Str];

=attr maxRequestBodyBytes

MaxRequestBodyBytes defines the maximum size allowed for the body of the request.
Default value is -1, which means unlimited size.

=cut

=attr status

Status defines the list of status code ranges for which the fallback service should be used.

=cut

1;
