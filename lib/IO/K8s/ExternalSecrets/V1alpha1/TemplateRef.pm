package IO::K8s::ExternalSecrets::V1alpha1::TemplateRef;
# ABSTRACT: TemplateRef specifies a reference to either a ConfigMap or a Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s items => ['+IO::K8s::ExternalSecrets::V1alpha1::TemplateRefItem'], { required => 'schema' };
k8s name  => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr items

A list of keys in the ConfigMap/Secret to use as templates for Secret data

=cut

=attr name

The name of the ConfigMap/Secret resource

=cut

1;
