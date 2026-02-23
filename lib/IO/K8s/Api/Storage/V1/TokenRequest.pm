package IO::K8s::Api::Storage::V1::TokenRequest;
# ABSTRACT: TokenRequest contains parameters of a service account token.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s audience => Str, 'required';

=attr audience

audience is the intended audience of the token in "TokenRequestSpec". It will default to the audiences of kube apiserver.

=cut

k8s expirationSeconds => Int;

=attr expirationSeconds

expirationSeconds is the duration of validity of the token in "TokenRequestSpec". It has the same default value of "ExpirationSeconds" in "TokenRequestSpec".

=cut

1;
