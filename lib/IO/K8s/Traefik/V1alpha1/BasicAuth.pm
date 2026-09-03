package IO::K8s::Traefik::V1alpha1::BasicAuth;
# ABSTRACT: BasicAuth holds the basic auth middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s headerField  => Str;
k8s realm        => Str;
k8s removeHeader => Bool;
k8s secret       => Str;

=attr headerField

HeaderField defines a header field to store the authenticated user.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/basicauth/#headerfield

=cut

=attr realm

Realm allows the protected resources on a server to be partitioned into a set of protection spaces, each with its own authentication scheme.
Default: traefik.

=cut

=attr removeHeader

RemoveHeader sets the removeHeader option to true to remove the authorization header before forwarding the request to your service.
Default: false.

=cut

=attr secret

Secret is the name of the referenced Kubernetes Secret containing user credentials.

=cut

1;
