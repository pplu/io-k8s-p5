package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::Preconditions;
# ABSTRACT: Preconditions must be fulfilled before an operation (update, delete, etc.) is carried out.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s resourceVersion => Str;

=attr resourceVersion

Specifies the target ResourceVersion

=cut

k8s uid => Str;

=attr uid

Specifies the target UID.

=cut

1;
