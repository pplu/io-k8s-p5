package IO::K8s::Api::Flowcontrol::V1beta3::FlowSchemaStatus;
# ABSTRACT: FlowSchemaStatus represents the current state of a FlowSchema.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s conditions => ['Flowcontrol::V1beta3::FlowSchemaCondition'];

=attr conditions

`conditions` is a list of the current states of FlowSchema.

=cut

1;
