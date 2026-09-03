package IO::K8s::Traefik::V1alpha1::RootCA;
# ABSTRACT: RootCA defines a reference to a Secret or a ConfigMap that holds a CA certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s configMap => Str;
k8s secret    => Str;

=attr configMap

ConfigMap defines the name of a ConfigMap that holds a CA certificate.
The referenced ConfigMap must contain a certificate under either a tls.ca or a ca.crt key.

=cut

=attr secret

Secret defines the name of a Secret that holds a CA certificate.
The referenced Secret must contain a certificate under either a tls.ca or a ca.crt key.

=cut

1;
