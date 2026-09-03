package IO::K8s::Traefik::V1alpha1::ContentType;
# ABSTRACT: ContentType holds the content-type middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s autoDetect => Bool;

=attr autoDetect

AutoDetect specifies whether to let the `Content-Type` header, if it has not been set by the backend,
be automatically set to a value derived from the contents of the response.

Deprecated: AutoDetect option is deprecated, Content-Type middleware is only meant to be used to enable the content-type detection, please remove any usage of this option.

=cut

1;
