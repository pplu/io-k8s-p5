package IO::K8s::Traefik::V1alpha1::Chain;
# ABSTRACT: Chain holds the configuration of the chain middleware.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s middlewares => ['Core::V1::SecretReference'];

=attr middlewares

Middlewares is the list of MiddlewareRef which composes the chain.

=cut

1;
