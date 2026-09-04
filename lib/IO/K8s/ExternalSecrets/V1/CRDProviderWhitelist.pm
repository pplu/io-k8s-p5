package IO::K8s::ExternalSecrets::V1::CRDProviderWhitelist;
# ABSTRACT: Whitelist optionally restricts which object names and requested properties are allowed to be read.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s rules => ['+IO::K8s::ExternalSecrets::V1::CRDProviderWhitelistRule'];

=attr rules

Rules is a list of allow rules. If rules are set, at least one rule must
match for a request to be allowed.

=cut

1;
