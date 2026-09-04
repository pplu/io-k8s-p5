package IO::K8s::ExternalSecrets::V1::ExternalSecretDataRemoteRef;
# ABSTRACT: Used to extract multiple key/value pairs from one secret Note: Extract does not support sourceRef.Generator or sourceRef.GeneratorRef.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conversionStrategy => Str, { enum => [qw(Default Unicode)] };
k8s decodingStrategy   => Str, { enum => [qw(Auto Base64 Base64URL None)] };
k8s key                => Str, { required => 'schema' };
k8s metadataPolicy     => Str, { enum => [qw(None Fetch)] };
k8s nullBytePolicy     => Str, { enum => [qw(Ignore Fail)] };
k8s property           => Str;
k8s version            => Str;

=attr conversionStrategy

Used to define a conversion Strategy. Defaults to Default when omitted.

=cut

=attr decodingStrategy

Used to define a decoding Strategy. Defaults to None when omitted.

=cut

=attr key

Key is the key used in the Provider, mandatory

=cut

=attr metadataPolicy

Policy for fetching tags/labels from provider secrets, possible options are Fetch, None. Defaults to None

=cut

=attr nullBytePolicy

Controls how ESO handles fetched secret data containing NUL bytes for this source.

=cut

=attr property

Used to select a specific property of the Provider value (if a map), if supported

=cut

=attr version

Used to select a specific version of the Provider value, if supported

=cut

1;
