package IO::K8s::Traefik::V1alpha1::Route;
# ABSTRACT: Route holds the HTTP route configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kind          => Str, { enum => [qw(Rule)] };
k8s match         => Str, { required => 'schema' };
k8s middlewares   => ['Core::V1::SecretReference'];
k8s observability => '+IO::K8s::Traefik::V1alpha1::RouterObservabilityConfig';
k8s priority      => Int, { maximum => '9223372036854775000' };
k8s services      => ['+IO::K8s::Traefik::V1alpha1::Service'];
k8s syntax        => Str;

=attr kind

Kind defines the kind of the route.
Rule is the only supported kind.
If not defined, defaults to Rule.

=cut

=attr match

Match defines the router's rule.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/routing/rules-and-priority/

=cut

=attr middlewares

Middlewares defines the list of references to Middleware resources.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/kubernetes/crd/http/middleware/

=cut

=attr observability

Observability defines the observability configuration for a router.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/routing/observability/

=cut

=attr priority

Priority defines the router's priority.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/routing/rules-and-priority/#priority

=cut

=attr services

Services defines the list of Service.
It can contain any combination of TraefikService and/or reference to a Kubernetes Service.

=cut

=attr syntax

Syntax defines the router's rule syntax.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/routing/rules-and-priority/#rulesyntax

Deprecated: Please do not use this field and rewrite the router rules to use the v3 syntax.

=cut

1;
