package IO::K8s::Cilium::V2::Authentication;
# ABSTRACT: Authentication is the required authentication type for the allowed traffic, if any.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mode => Str, { required => 'schema', enum => [qw(disabled required test-always-fail)] };

=attr mode

Mode is the required authentication mode for the allowed traffic, if any.

=cut

1;
