package IO::K8s::Api::Core::V1::HTTPHeader;
# ABSTRACT: HTTPHeader describes a custom header to be used in HTTP probes
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.

=cut

k8s value => Str, 'required';

=attr value

The header field value

=cut

1;
