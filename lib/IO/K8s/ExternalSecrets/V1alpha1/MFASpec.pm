package IO::K8s::ExternalSecrets::V1alpha1::MFASpec;
# ABSTRACT: MFASpec controls the behavior of the mfa generator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s algorithm  => Str;
k8s length     => Int;
k8s secret     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s timePeriod => Int;
k8s when       => Time;

=attr algorithm

Algorithm to use for encoding. Defaults to SHA1 as per the RFC.

=cut

=attr length

Length defines the token length. Defaults to 6 characters.

=cut

=attr secret

Secret is a secret selector to a secret containing the seed secret to generate the TOTP value from.

=cut

=attr timePeriod

TimePeriod defines how long the token can be active. Defaults to 30 seconds.

=cut

=attr when

When defines a time parameter that can be used to pin the origin time of the generated token.

=cut

1;
