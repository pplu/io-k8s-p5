package IO::K8s::ExternalSecrets::V1::TemplateRefItem;
# ABSTRACT: TemplateRefItem specifies a key in the ConfigMap/Secret to use as a template for Secret data.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key        => Str, { required => 'schema', pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s templateAs => Str, { enum => [qw(Values KeysAndValues)], default => 'Values' };

=attr key

A key in the ConfigMap/Secret

=cut

=attr templateAs

TemplateScope specifies how the template keys should be interpreted.

=cut

1;
