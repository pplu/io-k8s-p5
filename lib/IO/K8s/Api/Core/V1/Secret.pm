package IO::K8s::Api::Core::V1::Secret;
# ABSTRACT: Secret holds secret data of a certain type. The total bytes of the values in the Data field must be less than MaxSecretSize bytes.
our $VERSION = '1.001';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Secret holds secret data of a certain type. The total bytes of the values in the Data field must be less than MaxSecretSize bytes.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s data => { Str => 1 };

=attr data

Data contains the secret data. Each key must consist of alphanumeric characters, '-', '_' or '.'. The serialized form of the secret data is a base64 encoded string, representing the arbitrary (possibly non-string) data value here. Described in https://tools.ietf.org/html/rfc4648#section-4

=cut

k8s immutable => Bool;

=attr immutable

Immutable, if set to true, ensures that data stored in the Secret cannot be updated (only object metadata can be modified). If not set to true, the field can be modified at any time. Defaulted to nil.

=cut

k8s stringData => { Str => 1 };

=attr stringData

stringData allows specifying non-binary secret data in string form. It is provided as a write-only input field for convenience. All keys and values are merged into the data field on write, overwriting any existing values. The stringData field is never output when reading from the API.

=cut

k8s type => Str;

=attr type

Used to facilitate programmatic handling of secret data. More info: https://kubernetes.io/docs/concepts/configuration/secret/#secret-types

=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#secret-v1-core>

=cut
1;
