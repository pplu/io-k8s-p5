package IO::K8s::Traefik::V1alpha1::RouteTCP;
# ABSTRACT: RouteTCP holds the TCP route configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s match       => Str, { required => 'schema' };
k8s middlewares => ['Core::V1::SecretReference'];
k8s priority    => Int, { maximum => '9223372036854775000' };
k8s services    => ['+IO::K8s::Traefik::V1alpha1::ServiceTCP'];
k8s syntax      => Str, { enum => [qw(v3 v2)] };

=attr match

Match defines the router's rule.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/routing/rules-and-priority/

=cut

=attr middlewares

Middlewares defines the list of references to MiddlewareTCP resources.

=cut

=attr priority

Priority defines the router's priority.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/routing/rules-and-priority/#priority

=cut

=attr services

Services defines the list of TCP services.

=cut

=attr syntax

Syntax defines the router's rule syntax.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/routing/rules-and-priority/#rulesyntax

Deprecated: Please do not use this field and rewrite the router rules to use the v3 syntax.

=cut

1;
