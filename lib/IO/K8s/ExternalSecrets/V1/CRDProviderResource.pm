package IO::K8s::ExternalSecrets::V1::CRDProviderResource;
# ABSTRACT: Resource identifies the CRD by its API group, version and kind.
our $VERSION = '1.108';
use utf8;
use IO::K8s::Resource;

k8s group   => Str, { required => 'schema' };
k8s kind    => Str, { required => 'schema' };
k8s version => Str, { required => 'schema' };

=encoding UTF-8

=cut

=attr group

Group is the API group of the resource. Use "" (empty string) for core
Kubernetes resources such as ConfigMap; use e.g. "config.example.io"
for a CRD. The field is required to be present in the manifest — write
`group: ""` explicitly for core resources so typos fail at admission
time rather than later at discovery.

=cut

=attr kind

Kind is the Kubernetes resource kind (e.g. "MyCustomResource").

=cut

=attr version

Version is the API version of the resource (e.g. "v1alpha1").

=cut

1;
