package IO::K8s::Cilium::V2::EndpointStatusChange;
# ABSTRACT: EndpointStatusChange Indication of a change of status swagger:model EndpointStatusChange
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s code      => Str;
k8s message   => Str;
k8s state     => Str;
k8s timestamp => Str;

=attr code

Code indicate type of status change
Enum: ["ok","failed"]

=cut

=attr message

Status message

=cut

=attr state

state

=cut

=attr timestamp

Timestamp when status change occurred

=cut

1;
