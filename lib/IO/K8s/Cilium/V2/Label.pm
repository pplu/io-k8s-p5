package IO::K8s::Cilium::V2::Label;
# ABSTRACT: Label is Cilium's representation of a label.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key    => Str, { required => 'schema' };
k8s source => Str;
k8s value  => Str;

=attr key

No description in the upstream schema.

=cut

=attr source

Source can be one of the above values (e.g.: LabelSourceK8s).

=cut

=attr value

No description in the upstream schema.

=cut

1;
