package IO::K8s::Api::Networking::V1::HTTPIngressRuleValue;
# ABSTRACT: HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s paths => ['Networking::V1::HTTPIngressPath'], 'required';

=attr paths

paths is a collection of paths that map requests to backends.

=cut

1;
