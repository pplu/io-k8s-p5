package IO::K8s::Traefik::V1alpha1::TLSOptionSpec;
# ABSTRACT: TLSOptionSpec defines the desired state of a TLSOption.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alpnProtocols            => [Str];
k8s cipherSuites             => [Str];
k8s clientAuth               => '+IO::K8s::Traefik::V1alpha1::ClientAuth';
k8s curvePreferences         => [Str];
k8s disableSessionTickets    => Bool;
k8s maxVersion               => Str;
k8s minVersion               => Str;
k8s preferServerCipherSuites => Bool;
k8s sniStrict                => Bool;

=attr alpnProtocols

ALPNProtocols defines the list of supported application level protocols for the TLS handshake, in order of preference.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/tls/tls-certificates/#certificates-stores#alpn-protocols

=cut

=attr cipherSuites

CipherSuites defines the list of supported cipher suites for TLS versions up to TLS 1.2.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/tls/tls-certificates/#certificates-stores#cipher-suites

=cut

=attr clientAuth

ClientAuth defines the server's policy for TLS Client Authentication.

=cut

=attr curvePreferences

CurvePreferences defines the preferred elliptic curves.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/tls/tls-certificates/#certificates-stores#curve-preferences

=cut

=attr disableSessionTickets

DisableSessionTickets disables TLS session resumption via session tickets.

=cut

=attr maxVersion

MaxVersion defines the maximum TLS version that Traefik will accept.
Possible values: VersionTLS10, VersionTLS11, VersionTLS12, VersionTLS13.
Default: None.

=cut

=attr minVersion

MinVersion defines the minimum TLS version that Traefik will accept.
Possible values: VersionTLS10, VersionTLS11, VersionTLS12, VersionTLS13.
Default: VersionTLS10.

=cut

=attr preferServerCipherSuites

PreferServerCipherSuites defines whether the server chooses a cipher suite among his own instead of among the client's.
It is enabled automatically when minVersion or maxVersion is set.

Deprecated: https://github.com/golang/go/issues/45430

=cut

=attr sniStrict

SniStrict defines whether Traefik allows connections from clients connections that do not specify a server_name extension.

=cut

1;
