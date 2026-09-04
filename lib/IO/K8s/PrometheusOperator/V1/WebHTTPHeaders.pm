package IO::K8s::PrometheusOperator::V1::WebHTTPHeaders;
# ABSTRACT: headers defines a list of headers that can be added to HTTP responses.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s contentSecurityPolicy   => Str;
k8s strictTransportSecurity => Str;
k8s xContentTypeOptions     => Str, { enum => ['','NoSniff'] };
k8s xFrameOptions           => Str, { enum => ['','Deny','SameOrigin'] };
k8s xXSSProtection          => Str;

=attr contentSecurityPolicy

contentSecurityPolicy defines the Content-Security-Policy header to HTTP responses.
Unset if blank.

=cut

=attr strictTransportSecurity

strictTransportSecurity defines the Strict-Transport-Security header to HTTP responses.
Unset if blank.
Please make sure that you use this with care as this header might force
browsers to load Prometheus and the other applications hosted on the same
domain and subdomains over HTTPS.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security

=cut

=attr xContentTypeOptions

xContentTypeOptions defines the X-Content-Type-Options header to HTTP responses.
Unset if blank. Accepted value is nosniff.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options

=cut

=attr xFrameOptions

xFrameOptions defines the X-Frame-Options header to HTTP responses.
Unset if blank. Accepted values are deny and sameorigin.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options

=cut

=attr xXSSProtection

xXSSProtection defines the X-XSS-Protection header to all responses.
Unset if blank.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection

=cut

1;
