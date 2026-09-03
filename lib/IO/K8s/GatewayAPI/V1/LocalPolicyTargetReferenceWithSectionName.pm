package IO::K8s::GatewayAPI::V1::LocalPolicyTargetReferenceWithSectionName;
# ABSTRACT: LocalPolicyTargetReferenceWithSectionName identifies an API object to apply a direct policy to.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group       => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind        => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s name        => Str, { required => 'schema' };
k8s sectionName => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };

=attr group

Group is the group of the target resource.

=cut

=attr kind

Kind is kind of the target resource.

=cut

=attr name

Name is the name of the target resource.

=cut

=attr sectionName

SectionName is the name of a section within the target resource. When
unspecified, this targetRef targets the entire resource. In the following
resources, SectionName is interpreted as the following:

* Gateway: Listener name
* HTTPRoute: HTTPRouteRule name
* Service: Port name

If a SectionName is specified, but does not exist on the targeted object,
the Policy must fail to attach, and the policy implementation should record
a `ResolvedRefs` or similar Condition in the Policy's status.

=cut

1;
