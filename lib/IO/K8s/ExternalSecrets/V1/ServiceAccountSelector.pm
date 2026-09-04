package IO::K8s::ExternalSecrets::V1::ServiceAccountSelector;
# ABSTRACT: Service account field containing the name of a kubernetes ServiceAccount.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s audiences => [Str];
k8s name      => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr audiences

Audience specifies the `aud` claim for the service account token
Some providers automatically extend the audience field based on well-known annotations for workload
identity (e.g. IRSA or GCP Workload Identity)

=cut

=attr name

The name of the ServiceAccount resource being referred to.

=cut

=attr namespace

Namespace of the resource being referred to.
Ignored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.

=cut

1;
