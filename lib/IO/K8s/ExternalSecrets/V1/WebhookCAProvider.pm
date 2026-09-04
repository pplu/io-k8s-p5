package IO::K8s::ExternalSecrets::V1::WebhookCAProvider;
# ABSTRACT: The provider for the CA bundle to use to validate webhook server certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key       => Str, { pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s name      => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };
k8s type      => Str, { required => 'schema', enum => [qw(Secret ConfigMap)] };

=attr key

The key where the CA certificate can be found in the Secret or ConfigMap.

=cut

=attr name

The name of the object located at the provider type.

=cut

=attr namespace

The namespace the Provider type is in.

=cut

=attr type

The type of provider to use such as "Secret", or "ConfigMap".

=cut

1;
