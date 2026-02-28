package IO::K8s::Api::Authorization::V1::NonResourceRule;
# ABSTRACT: NonResourceRule holds information that describes a rule for the non-resource
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s nonResourceURLs => [Str];

=attr nonResourceURLs

NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path.  "*" means all.

=cut

k8s verbs => [Str], 'required';

=attr verbs

Verb is a list of kubernetes non-resource API verbs, like: get, post, put, delete, patch, head, options.  "*" means all.

=cut

1;
