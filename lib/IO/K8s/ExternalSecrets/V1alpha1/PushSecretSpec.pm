package IO::K8s::ExternalSecrets::V1alpha1::PushSecretSpec;
# ABSTRACT: PushSecretSpec configures the behavior of the PushSecret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s data            => ['+IO::K8s::ExternalSecrets::V1alpha1::PushSecretData'];
k8s dataTo          => ['+IO::K8s::ExternalSecrets::V1alpha1::PushSecretDataTo'];
k8s deletionPolicy  => Str, { enum => [qw(Delete None)], default => 'None' };
k8s refreshInterval => Str, { default => '1h0m0s' };
k8s secretStoreRefs => ['+IO::K8s::ExternalSecrets::V1alpha1::PushSecretStoreRef'], { required => 'schema' };
k8s selector        => '+IO::K8s::ExternalSecrets::V1alpha1::PushSecretSelector', { required => 'schema' };
k8s template        => '+IO::K8s::ExternalSecrets::V1alpha1::ExternalSecretTemplate';
k8s updatePolicy    => Str, { enum => [qw(Replace IfNotExists)], default => 'Replace' };

=attr data

Secret Data that should be pushed to providers

=cut

=attr dataTo

DataTo defines bulk push rules that expand source Secret keys into provider entries.

=cut

=attr deletionPolicy

Deletion Policy to handle Secrets in the provider.

=cut

=attr refreshInterval

The Interval to which External Secrets will try to push a secret definition

=cut

=attr secretStoreRefs

No description in the upstream schema.

=cut

=attr selector

The Secret Selector (k8s source) for the Push Secret

=cut

=attr template

Template defines a blueprint for the created Secret resource.

=cut

=attr updatePolicy

UpdatePolicy to handle Secrets in the provider.

=cut

1;
