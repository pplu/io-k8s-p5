package IO::K8s::Traefik::V1alpha1::Compress;
# ABSTRACT: Compress holds the compress middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s defaultEncoding      => Str;
k8s encodings            => [Str];
k8s excludedContentTypes => [Str];
k8s includedContentTypes => [Str];
k8s minResponseBodyBytes => Int, { minimum => 0 };

=attr defaultEncoding

DefaultEncoding specifies the default encoding if the `Accept-Encoding` header is not in the request or contains a wildcard (`*`).

=cut

=attr encodings

Encodings defines the list of supported compression algorithms.

=cut

=attr excludedContentTypes

ExcludedContentTypes defines the list of content types to compare the Content-Type header of the incoming requests and responses before compressing.
`application/grpc` is always excluded.

=cut

=attr includedContentTypes

IncludedContentTypes defines the list of content types to compare the Content-Type header of the responses before compressing.

=cut

=attr minResponseBodyBytes

MinResponseBodyBytes defines the minimum amount of bytes a response body must have to be compressed.
Default: 1024.

=cut

1;
