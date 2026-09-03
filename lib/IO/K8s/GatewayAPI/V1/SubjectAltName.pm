package IO::K8s::GatewayAPI::V1::SubjectAltName;
# ABSTRACT: SubjectAltName represents Subject Alternative Name.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hostname => Str, { pattern => qr/^(\*\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s type     => Str, { required => 'schema', enum => [qw(Hostname URI)] };
k8s uri      => Str, { pattern => qr/^(([^:\/?#]+):)(\/\/([^\/?#]*))([^?#]*)(\?([^#]*))?(#(.*))?/ };

=attr hostname

Hostname contains Subject Alternative Name specified in DNS name format.
Required when Type is set to Hostname, ignored otherwise.

Support: Core

=cut

=attr type

Type determines the format of the Subject Alternative Name. Always required.

Support: Core

=cut

=attr uri

URI contains Subject Alternative Name specified in a full URI format.
It MUST include both a scheme (e.g., "http" or "ftp") and a scheme-specific-part.
Common values include SPIFFE IDs like "spiffe://mycluster.example.com/ns/myns/sa/svc1sa".
Required when Type is set to URI, ignored otherwise.

Support: Core

=cut

1;
