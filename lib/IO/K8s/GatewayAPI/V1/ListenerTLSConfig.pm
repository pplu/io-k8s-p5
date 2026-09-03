package IO::K8s::GatewayAPI::V1::ListenerTLSConfig;
# ABSTRACT: TLS is the TLS configuration for the Listener.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certificateRefs => ['+IO::K8s::GatewayAPI::V1::SecretObjectReference'];
k8s mode            => Str, { enum => [qw(Terminate Passthrough)], default => 'Terminate' };
k8s options         => { Str => 1 };

=attr certificateRefs

CertificateRefs contains a series of references to Kubernetes objects that
contains TLS certificates and private keys. These certificates are used to
establish a TLS handshake for requests that match the hostname of the
associated listener.

A single CertificateRef to a Kubernetes Secret has "Core" support.
Implementations MAY choose to support attaching multiple certificates to
a Listener, but this behavior is implementation-specific.

References to a resource in different namespace are invalid UNLESS there
is a ReferenceGrant in the target namespace that allows the certificate
to be attached. If a ReferenceGrant does not allow this reference, the
"ResolvedRefs" condition MUST be set to False for this listener with the
"RefNotPermitted" reason.

This field is required to have at least one element when the mode is set
to "Terminate" (default) and is optional otherwise.

CertificateRefs can reference to standard Kubernetes resources, i.e.
Secret, or implementation-specific custom resources.

Support: Core - A single reference to a Kubernetes Secret of type kubernetes.io/tls

Support: Implementation-specific (More than one reference or other resource types)

=cut

=attr mode

Mode defines the TLS behavior for the TLS session initiated by the client.
There are two possible modes:

- Terminate: The TLS session between the downstream client and the
  Gateway is terminated at the Gateway. This mode requires certificates
  to be specified in some way, such as populating the certificateRefs
  field.
- Passthrough: The TLS session is NOT terminated by the Gateway. This
  implies that the Gateway can't decipher the TLS stream except for
  the ClientHello message of the TLS protocol. The certificateRefs field
  is ignored in this mode.

Support: Core

=cut

=attr options

Options are a list of key/value pairs to enable extended TLS
configuration for each implementation. For example, configuring the
minimum TLS version or supported cipher suites.

A set of common keys MAY be defined by the API in the future. To avoid
any ambiguity, implementation-specific definitions MUST use
domain-prefixed names, such as `example.com/my-custom-option`.
Un-prefixed names are reserved for key names defined by Gateway API.

Support: Implementation-specific

=cut

1;
