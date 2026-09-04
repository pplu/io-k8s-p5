package IO::K8s::ExternalSecrets::V1::IntegrationInfo;
# ABSTRACT: IntegrationInfo specifies the name and version of the integration built using the 1Password Go SDK.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name    => Str, { default => '1Password SDK' };
k8s version => Str, { default => 'v1.0.0' };

=attr name

Name defaults to "1Password SDK".

=cut

=attr version

Version defaults to "v1.0.0".

=cut

1;
