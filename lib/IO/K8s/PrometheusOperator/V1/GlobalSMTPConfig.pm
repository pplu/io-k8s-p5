package IO::K8s::PrometheusOperator::V1::GlobalSMTPConfig;
# ABSTRACT: smtp defines global SMTP parameters.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authIdentity     => Str;
k8s authPassword     => 'Core::V1::ConfigMapKeySelector';
k8s authSecret       => 'Core::V1::ConfigMapKeySelector';
k8s authUsername     => Str;
k8s forceImplicitTLS => Bool;
k8s from             => Str;
k8s hello            => Str;
k8s requireTLS       => Bool;
k8s smartHost        => '+IO::K8s::PrometheusOperator::V1::HostPort';
k8s tlsConfig        => '+IO::K8s::PrometheusOperator::V1::SafeTLSConfig';

=attr authIdentity

authIdentity represents SMTP Auth using PLAIN

=cut

=attr authPassword

authPassword represents SMTP Auth using LOGIN and PLAIN.

=cut

=attr authSecret

authSecret represents SMTP Auth using CRAM-MD5.

=cut

=attr authUsername

authUsername represents SMTP Auth using CRAM-MD5, LOGIN and PLAIN. If empty, Alertmanager doesn't authenticate to the SMTP server.

=cut

=attr forceImplicitTLS

forceImplicitTLS defines whether to force use of implicit TLS (direct TLS connection) for better security.
true: force use of implicit TLS (direct TLS connection on any port)
false: force disable implicit TLS (use explicit TLS/STARTTLS if required)
nil (default): auto-detect based on port (465=implicit, other=explicit) for backward compatibility
It requires Alertmanager >= v0.31.0.

=cut

=attr from

from defines the default SMTP From header field.

=cut

=attr hello

hello defines the default hostname to identify to the SMTP server.

=cut

=attr requireTLS

requireTLS defines the default SMTP TLS requirement.
Note that Go does not support unencrypted connections to remote SMTP endpoints.

=cut

=attr smartHost

smartHost defines the default SMTP smarthost used for sending emails.

=cut

=attr tlsConfig

tlsConfig defines the default TLS configuration for SMTP receivers

=cut

1;
