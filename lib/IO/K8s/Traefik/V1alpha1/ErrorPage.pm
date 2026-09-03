package IO::K8s::Traefik::V1alpha1::ErrorPage;
# ABSTRACT: ErrorPage holds the custom error middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s errorRequestHeaders => [Str];
k8s query               => Str;
k8s service             => '+IO::K8s::Traefik::V1alpha1::Service';
k8s status              => [Str], { pattern => qr/^([1-5][0-9]{2}[,-]?)+$/ };
k8s statusRewrites      => { Str => 1 };

=attr errorRequestHeaders

ErrorRequestHeaders defines the list of request headers forwarded to the error page service.
When nil (not set), all original request headers are forwarded.
Set to an empty list to forward no headers, or list specific headers to forward only those.

=cut

=attr query

Query defines the URL for the error page (hosted by service).
The {status} variable can be used in order to insert the status code in the URL.
The {originalStatus} variable can be used in order to insert the upstream status code in the URL.
The {url} variable can be used in order to insert the escaped request URL.

=cut

=attr service

Service defines the reference to a Kubernetes Service that will serve the error page.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/errorpages/#service

=cut

=attr status

Status defines which status or range of statuses should result in an error page.
It can be either a status code as a number (500),
as multiple comma-separated numbers (500,502),
as ranges by separating two codes with a dash (500-599),
or a combination of the two (404,418,500-599).

=cut

=attr statusRewrites

StatusRewrites defines a mapping of status codes that should be returned instead of the original error status codes.
For example: "418": 404 or "410-418": 404

=cut

1;
