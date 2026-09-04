package IO::K8s::ExternalSecrets::V1::OvhProvider;
# ABSTRACT: OVHcloud configures this store to sync secrets using the OVHcloud provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth        => '+IO::K8s::ExternalSecrets::V1::OvhAuth', { required => 'schema' };
k8s casRequired => Bool;
k8s okmsTimeout => Int, { minimum => 1, default => 30 };
k8s okmsid      => Str, { required => 'schema' };
k8s server      => Str, { required => 'schema' };

=attr auth

Authentication method (mtls or token).

=cut

=attr casRequired

Enables or disables check-and-set (CAS) (default: false).

=cut

=attr okmsTimeout

Setup a timeout in seconds when requests to the KMS are made (default: 30).

=cut

=attr okmsid

specifies the OKMS ID.

=cut

=attr server

specifies the OKMS server endpoint.

=cut

1;
