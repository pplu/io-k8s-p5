package IO::K8s::ExternalSecrets::V1alpha1::PasswordSpec;
# ABSTRACT: PasswordSpec controls the behavior of the password generator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowRepeat      => Bool, { required => 'schema', default => 0 };
k8s digits           => Int;
k8s encoding         => Str, { enum => [qw(base64 base64url base32 hex raw)], default => 'raw' };
k8s length           => Int, { required => 'schema', default => 24 };
k8s noUpper          => Bool, { required => 'schema', default => 0 };
k8s secretKeys       => [Str];
k8s symbolCharacters => Str;
k8s symbols          => Int;

=attr allowRepeat

set AllowRepeat to true to allow repeating characters.

=cut

=attr digits

Digits specifies the number of digits in the generated
password. If omitted it defaults to 25% of the length of the password

=cut

=attr encoding

Encoding specifies the encoding of the generated password.
Valid values are:
- "raw" (default): no encoding
- "base64": standard base64 encoding
- "base64url": base64url encoding
- "base32": base32 encoding
- "hex": hexadecimal encoding

=cut

=attr length

Length of the password to be generated.
Defaults to 24

=cut

=attr noUpper

Set NoUpper to disable uppercase characters

=cut

=attr secretKeys

SecretKeys defines the keys that will be populated with generated passwords.
Defaults to "password" when not set.

=cut

=attr symbolCharacters

SymbolCharacters specifies the special characters that should be used
in the generated password.

=cut

=attr symbols

Symbols specifies the number of symbol characters in the generated
password. If omitted it defaults to 25% of the length of the password

=cut

1;
