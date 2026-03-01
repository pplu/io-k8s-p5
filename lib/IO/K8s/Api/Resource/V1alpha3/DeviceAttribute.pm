package IO::K8s::Api::Resource::V1alpha3::DeviceAttribute;
# ABSTRACT: DeviceAttribute must have exactly one field set.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s bool => Bool;

=attr bool

BoolValue is a true/false value.

=cut

k8s int => Int;

=attr int

IntValue is a number.

=cut

k8s string => Str;

=attr string

StringValue is a string. Must not be longer than 64 characters.

=cut

k8s version => Str;

=attr version

VersionValue is a semantic version according to semver.org spec 2.0.0. Must not be longer than 64 characters.

=cut

1;
