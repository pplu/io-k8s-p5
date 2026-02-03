package IO::K8s::Api::Discovery::V1::Endpoint;
# ABSTRACT: Endpoint represents a single logical "backend" implementing a service.

use IO::K8s::Resource;

k8s addresses => [Str], 'required';

=attr addresses

addresses of this endpoint. The contents of this field are interpreted according to the corresponding EndpointSlice addressType field. Consumers must handle different types of addresses in the context of their own capabilities. This must contain at least one address but no more than 100. These are all assumed to be fungible and clients may choose to only use the first element. Refer to: https://issue.k8s.io/106267

=cut

k8s conditions => 'Discovery::V1::EndpointConditions';

=attr conditions

conditions contains information about the current status of the endpoint.

=cut

k8s deprecatedTopology => { Str => 1 };

=attr deprecatedTopology

deprecatedTopology contains topology information part of the v1beta1 API. This field is deprecated, and will be removed when the v1beta1 API is removed (no sooner than kubernetes v1.24).  While this field can hold values, it is not writable through the v1 API, and any attempts to write to it will be silently ignored. Topology information can be found in the zone and nodeName fields instead.

=cut

k8s hints => 'Discovery::V1::EndpointHints';

=attr hints

hints contains information associated with how an endpoint should be consumed.

=cut

k8s hostname => Str;

=attr hostname

hostname of this endpoint. This field may be used by consumers of endpoints to distinguish endpoints from each other (e.g. in DNS names). Multiple endpoints which use the same hostname should be considered fungible (e.g. multiple A values in DNS). Must be lowercase and pass DNS Label (RFC 1123) validation.

=cut

k8s nodeName => Str;

=attr nodeName

nodeName represents the name of the Node hosting this endpoint. This can be used to determine endpoints local to a Node.

=cut

k8s targetRef => 'Core::V1::ObjectReference';

=attr targetRef

targetRef is a reference to a Kubernetes object that represents this endpoint.

=cut

k8s zone => Str;

=attr zone

zone is the name of the Zone this endpoint exists in.

=cut

1;
