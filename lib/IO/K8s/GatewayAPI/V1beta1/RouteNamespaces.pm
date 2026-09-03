package IO::K8s::GatewayAPI::V1beta1::RouteNamespaces;
# ABSTRACT: Namespaces indicates namespaces from which Routes may be attached to this Listener.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s from     => Str, { enum => [qw(All Selector Same)], default => 'Same' };
k8s selector => 'Meta::V1::LabelSelector';

=attr from

From indicates where Routes will be selected for this Gateway. Possible
values are:

* All: Routes in all namespaces may be used by this Gateway.
* Selector: Routes in namespaces selected by the selector may be used by
  this Gateway.
* Same: Only Routes in the same namespace may be used by this Gateway.

Support: Core

=cut

=attr selector

Selector must be specified when From is set to "Selector". In that case,
only Routes in Namespaces matching this Selector will be selected by this
Gateway. This field is ignored for other values of "From".

Support: Core

=cut

1;
