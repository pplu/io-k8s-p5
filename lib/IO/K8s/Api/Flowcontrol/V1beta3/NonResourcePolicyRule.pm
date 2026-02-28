package IO::K8s::Api::Flowcontrol::V1beta3::NonResourcePolicyRule;
# ABSTRACT: NonResourcePolicyRule is a predicate that matches non-resource requests according to their verb and the target non-resource URL. A NonResourcePolicyRule matches a request if and only if both (a) at least one member of verbs matches the request and (b) at least one member of nonResourceURLs matches the request.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s nonResourceURLs => [Str], 'required';

=attr nonResourceURLs

C<nonResourceURLs> is a set of url prefixes that a user should have access to and may not be empty. For example:

=over 4

=item * "/healthz" is legal

=item * "/hea*" is illegal

=item * "/hea" is legal but matches nothing

=item * "/hea/*" also matches nothing

=item * "/healthz/*" matches all per-component health checks.

=back

"*" matches all non-resource urls. if it is present, it must be the only entry. Required.

=cut

k8s verbs => [Str], 'required';

=attr verbs

C<verbs> is a list of matching verbs and may not be empty. "*" matches all verbs. If it is present, it must be the only entry. Required.

=cut

1;
