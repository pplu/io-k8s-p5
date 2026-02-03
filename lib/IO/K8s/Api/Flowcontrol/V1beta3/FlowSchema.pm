package IO::K8s::Api::Flowcontrol::V1beta3::FlowSchema;
# ABSTRACT: FlowSchema defines the schema of a group of flows. Note that a flow is made up of a set of inbound API requests with similar attributes and is identified by a pair of strings: the name of the FlowSchema and a "flow distinguisher".

use IO::K8s::APIObject;

=head1 DESCRIPTION

FlowSchema defines the schema of a group of flows. Note that a flow is made up of a set of inbound API requests with similar attributes and is identified by a pair of strings: the name of the FlowSchema and a "flow distinguisher".

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Flowcontrol::V1beta3::FlowSchemaSpec';

=attr spec

C<spec> is the specification of the desired behavior of a FlowSchema. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Flowcontrol::V1beta3::FlowSchemaStatus';

=attr status

C<status> is the current status of a FlowSchema. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
