package IO::K8s::Api::Core::V1::ConfigMap;
# ABSTRACT: ConfigMap holds configuration data for pods to consume.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ConfigMap holds configuration data for pods to consume.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s binaryData => { Str => 1 };

=attr binaryData

BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.


=cut

k8s data => { Str => 1 };

=attr data

Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process.


=cut

k8s immutable => Bool;

=attr immutable

Immutable, if set to true, ensures that data stored in the ConfigMap cannot be updated (only object metadata can be modified). If not set to true, the field can be modified at any time. Defaulted to nil.


=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#configmap-v1-core>


=cut

1;
