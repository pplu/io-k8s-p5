package IO::K8s::GatewayAPI::V1::ListenerNamespaces;
# ABSTRACT: Namespaces defines which namespaces ListenerSets can be attached to this Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s from     => Str, { enum => [qw(All Selector Same None)], default => 'None' };
k8s selector => 'Meta::V1::LabelSelector';

=attr from

From indicates where ListenerSets can attach to this Gateway. Possible
values are:

* Same: Only ListenerSets in the same namespace may be attached to this Gateway.
* Selector: ListenerSets in namespaces selected by the selector may be attached to this Gateway.
* All: ListenerSets in all namespaces may be attached to this Gateway.
* None: Only listeners defined in the Gateway's spec are allowed

The default value None

=cut

=attr selector

Selector must be specified when From is set to "Selector". In that case,
only ListenerSets in Namespaces matching this Selector will be selected by this
Gateway. This field is ignored for other values of "From".

=cut

1;
