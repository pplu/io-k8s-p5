package IO::K8s::ExternalSecrets::V1::ExternalSecretFind;
# ABSTRACT: Used to find secrets based on tags or regular expressions Note: Find does not support sourceRef.Generator or sourceRef.GeneratorRef.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conversionStrategy => Str, { enum => [qw(Default Unicode)] };
k8s decodingStrategy   => Str, { enum => [qw(Auto Base64 Base64URL None)] };
k8s name               => '+IO::K8s::ExternalSecrets::V1::FindName';
k8s nullBytePolicy     => Str, { enum => [qw(Ignore Fail)] };
k8s path               => Str;
k8s tags               => { Str => 1 };

=attr conversionStrategy

Used to define a conversion Strategy. Defaults to Default when omitted.

=cut

=attr decodingStrategy

Used to define a decoding Strategy. Defaults to None when omitted.

=cut

=attr name

Finds secrets based on the name.

=cut

=attr nullBytePolicy

Controls how ESO handles fetched secret data containing NUL bytes for this find source.

=cut

=attr path

A root path to start the find operations.

=cut

=attr tags

Find secrets based on tags.

=cut

1;
