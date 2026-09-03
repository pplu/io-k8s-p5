package IO::K8s::Cilium::V2::LogConfig;
# ABSTRACT: Log specifies custom policy-specific Hubble logging configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s value => Str, { pattern => qr/^\PC*$/ };

=attr value

Value is a free-form string that is included in Hubble flows
that match this policy. The string is limited to 32 printable characters.

=cut

1;
