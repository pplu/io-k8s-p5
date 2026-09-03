package IO::K8s::GatewayAPI::V1::ParentReference;
# ABSTRACT: ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group       => Str, { pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/, default => 'gateway.networking.k8s.io' };
k8s kind        => Str, { pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/, default => 'Gateway' };
k8s name        => Str, { required => 'schema' };
k8s namespace   => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };
k8s port        => Int, { minimum => 1, maximum => 65535 };
k8s sectionName => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr group

Group is the group of the referent.
When unspecified, "gateway.networking.k8s.io" is inferred.
To set the core API group (such as for a "Service" kind referent),
Group must be explicitly set to "" (empty string).

Support: Core

=cut

=attr kind

Kind is kind of the referent.

There are two kinds of parent resources with "Core" support:

* Gateway (Gateway conformance profile)
* Service (Mesh conformance profile, ClusterIP Services only)

Support for other resources is Implementation-Specific.

=cut

=attr name

Name is the name of the referent.

Support: Core

=cut

=attr namespace

Namespace is the namespace of the referent. When unspecified, this refers
to the local namespace of the Route.

Note that there are specific rules for ParentRefs which cross namespace
boundaries. Cross-namespace references are only valid if they are explicitly
allowed by something in the namespace they are referring to. For example:
Gateway has the AllowedRoutes field, and ReferenceGrant provides a
generic way to enable any other kind of cross-namespace reference.

Support: Core

=cut

=attr port

Port is the network port this Route targets. It can be interpreted
differently based on the type of parent resource.

When the parent resource is a Gateway, this targets all listeners
listening on the specified port that also support this kind of Route(and
select this Route). It's not recommended to set `Port` unless the
networking behaviors specified in a Route must apply to a specific port
as opposed to a listener(s) whose port(s) may be changed. When both Port
and SectionName are specified, the name and port of the selected listener
must match both specified values.

Implementations MAY choose to support other parent resources.
Implementations supporting other types of parent resources MUST clearly
document how/if Port is interpreted.

For the purpose of status, an attachment is considered successful as
long as the parent resource accepts it partially. For example, Gateway
listeners can restrict which Routes can attach to them by Route kind,
namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
from the referencing Route, the Route MUST be considered successfully
attached. If no Gateway listeners accept attachment from this Route,
the Route MUST be considered detached from the Gateway.

Support: Extended

=cut

=attr sectionName

SectionName is the name of a section within the target resource. In the
following resources, SectionName is interpreted as the following:

* Gateway: Listener name. When both Port (experimental) and SectionName
are specified, the name and port of the selected listener must match
both specified values.
* Service: Port name. When both Port (experimental) and SectionName
are specified, the name and port of the selected listener must match
both specified values.

Implementations MAY choose to support attaching Routes to other resources.
If that is the case, they MUST clearly document how SectionName is
interpreted.

When unspecified (empty string), this will reference the entire resource.
For the purpose of status, an attachment is considered successful if at
least one section in the parent resource accepts it. For example, Gateway
listeners can restrict which Routes can attach to them by Route kind,
namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
the referencing Route, the Route MUST be considered successfully
attached. If no Gateway listeners accept attachment from this Route, the
Route MUST be considered detached from the Gateway.

Support: Core

=cut

1;
