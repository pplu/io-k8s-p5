package IO::K8s::Api::Core::V1::Sysctl;
# ABSTRACT: Sysctl defines a kernel parameter to be set
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name of a property to set

=cut

k8s value => Str, 'required';

=attr value

Value of a property to set

=cut

1;
