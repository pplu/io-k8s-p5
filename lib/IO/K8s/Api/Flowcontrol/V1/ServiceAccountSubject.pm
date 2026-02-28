package IO::K8s::Api::Flowcontrol::V1::ServiceAccountSubject;
# ABSTRACT: ServiceAccountSubject holds detailed information for service-account-kind subject.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

`name` is the name of matching ServiceAccount objects, or "*" to match regardless of name. Required.

=cut

k8s namespace => Str, 'required';

=attr namespace

`namespace` is the namespace of matching ServiceAccount objects. Required.

=cut

1;
