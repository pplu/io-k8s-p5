package IO::K8s::Api::Resource::V1beta2::DeviceAttribute;
# ABSTRACT: DeviceAttribute must have exactly one field set.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s bool => Bool;

=attr bool

BoolValue is a true/false value.

=cut

k8s bools => [Bool];

=attr bools

BoolValues is a non-empty list of true/false values.

=cut

k8s int => Int;

=attr int

IntValue is a number.

=cut

k8s ints => [Int];

=attr ints

IntValues is a non-empty list of numbers.  This is an alpha field and requires enabling the DRAListTypeAttributes feature gate.

=cut

k8s string => Str;

=attr string

StringValue is a string. Must not be longer than 64 characters.

=cut

k8s strings => [Str];

=attr strings

StringValues is a non-empty list of strings. Each string must not be longer than 64 characters.  This is an alpha field and requires enabling the DRAListTypeAttributes feature gate.

=cut

k8s version => Str;

=attr version

VersionValue is a semantic version according to semver.org spec 2.0.0. Must not be longer than 64 characters.

=cut

k8s versions => [Str];

=attr versions

VersionValues is a non-empty list of semantic versions according to semver.org spec 2.0.0. Each version string must not be longer than 64 characters.  This is an alpha field and requires enabling the DRAListTypeAttributes feature gate.

=cut

1;
