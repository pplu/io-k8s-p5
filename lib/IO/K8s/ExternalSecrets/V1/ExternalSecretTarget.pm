package IO::K8s::ExternalSecrets::V1::ExternalSecretTarget;
# ABSTRACT: ExternalSecretTarget defines the Kubernetes Secret to be created, there can be only one target per ExternalSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s creationPolicy => Str, { enum => [qw(Owner Orphan Merge None CreateOrMerge)], default => 'Owner' };
k8s deletionPolicy => Str, { enum => [qw(Delete Merge Retain)], default => 'Retain' };
k8s immutable      => Bool;
k8s manifest       => 'Admissionregistration::V1::ParamKind';
k8s name           => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s template       => '+IO::K8s::ExternalSecrets::V1::ExternalSecretTemplate';

=attr creationPolicy

CreationPolicy defines rules on how to create the resulting Secret.
Defaults to "Owner"

=cut

=attr deletionPolicy

DeletionPolicy defines rules on how to delete the resulting Secret.
Defaults to "Retain"

=cut

=attr immutable

Immutable defines if the final secret will be immutable

=cut

=attr manifest

Manifest defines a custom Kubernetes resource to create instead of a Secret.
When specified, ExternalSecret will create the resource type defined here
(e.g., ConfigMap, Custom Resource) instead of a Secret.
Warning: Using Generic target. Make sure access policies and encryption are properly configured.

=cut

=attr name

The name of the Secret resource to be managed.
Defaults to the .metadata.name of the ExternalSecret resource

=cut

=attr template

Template defines a blueprint for the created Secret resource.

=cut

1;
