package IO::K8s::Traefik::V1alpha1::TLSTCP;
# ABSTRACT: TLS defines the TLS configuration on a layer 4 / TCP Route.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certResolver => Str;
k8s domains      => ['+IO::K8s::Traefik::V1alpha1::Domain'];
k8s options      => 'Core::V1::SecretReference';
k8s passthrough  => Bool;
k8s secretName   => Str;
k8s store        => 'Core::V1::SecretReference';

=attr certResolver

CertResolver defines the name of the certificate resolver to use.
Cert resolvers have to be configured in the static configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/install-configuration/tls/certificate-resolvers/acme/

=cut

=attr domains

Domains defines the list of domains that will be used to issue certificates.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/tls/#domains

=cut

=attr options

Options defines the reference to a TLSOption, that specifies the parameters of the TLS connection.
If not defined, the `default` TLSOption is used.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/tcp/tls/#tls-options

=cut

=attr passthrough

Passthrough defines whether a TLS router will terminate the TLS connection.

=cut

=attr secretName

SecretName is the name of the referenced Kubernetes Secret to specify the certificate details.

=cut

=attr store

Store defines the reference to the TLSStore, that will be used to store certificates.
Please note that only `default` TLSStore can be used.

=cut

1;
