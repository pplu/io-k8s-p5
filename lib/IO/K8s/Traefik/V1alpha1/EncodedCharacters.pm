package IO::K8s::Traefik::V1alpha1::EncodedCharacters;
# ABSTRACT: EncodedCharacters configures which encoded characters are allowed in the request path.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowEncodedBackSlash     => Bool;
k8s allowEncodedHash          => Bool;
k8s allowEncodedNullCharacter => Bool;
k8s allowEncodedPercent       => Bool;
k8s allowEncodedQuestionMark  => Bool;
k8s allowEncodedSemicolon     => Bool;
k8s allowEncodedSlash         => Bool;

=attr allowEncodedBackSlash

AllowEncodedBackSlash defines whether requests with encoded back slash characters in the path are allowed.

=cut

=attr allowEncodedHash

AllowEncodedHash defines whether requests with encoded hash characters in the path are allowed.

=cut

=attr allowEncodedNullCharacter

AllowEncodedNullCharacter defines whether requests with encoded null characters in the path are allowed.

=cut

=attr allowEncodedPercent

AllowEncodedPercent defines whether requests with encoded percent characters in the path are allowed.

=cut

=attr allowEncodedQuestionMark

AllowEncodedQuestionMark defines whether requests with encoded question mark characters in the path are allowed.

=cut

=attr allowEncodedSemicolon

AllowEncodedSemicolon defines whether requests with encoded semicolon characters in the path are allowed.

=cut

=attr allowEncodedSlash

AllowEncodedSlash defines whether requests with encoded slash characters in the path are allowed.

=cut

1;
