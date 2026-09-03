package IO::K8s::GatewayAPI::V1::HTTPPathModifier;
# ABSTRACT: Path defines a path rewrite.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s replaceFullPath    => Str;
k8s replacePrefixMatch => Str;
k8s type               => Str, { required => 'schema', enum => [qw(ReplaceFullPath ReplacePrefixMatch)] };

=attr replaceFullPath

ReplaceFullPath specifies the value with which to replace the full path
of a request during a rewrite or redirect.

=cut

=attr replacePrefixMatch

ReplacePrefixMatch specifies the value with which to replace the prefix
match of a request during a rewrite or redirect. For example, a request
to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
of "/xyz" would be modified to "/xyz/bar".

Note that this matches the behavior of the PathPrefix match type. This
matches full path elements. A path element refers to the list of labels
in the path split by the `/` separator. When specified, a trailing `/` is
ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
match the prefix `/abc`, but the path `/abcd` would not.

ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
the implementation setting the Accepted Condition for the Route to `status: False`.

Request Path | Prefix Match | Replace Prefix | Modified Path

=cut

=attr type

Type defines the type of path modifier. Additional types may be
added in a future release of the API.

Note that values may be added to this enum, implementations
must ensure that unknown values will not cause a crash.

Unknown values here must result in the implementation setting the
Accepted Condition for the Route to `status: False`, with a
Reason of `UnsupportedValue`.

=cut

1;
