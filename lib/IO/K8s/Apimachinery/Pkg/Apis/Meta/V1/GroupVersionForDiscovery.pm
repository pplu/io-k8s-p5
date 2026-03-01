package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::GroupVersionForDiscovery;
# ABSTRACT: GroupVersion contains the "group/version" and "version" string of a version. It is made a struct to keep extensibility.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s groupVersion => Str, 'required';

=attr groupVersion

groupVersion specifies the API group and version in the form "group/version"

=cut

k8s version => Str, 'required';

=attr version

version specifies the version in the form of "version". This is to save the clients the trouble of splitting the GroupVersion.

=cut

1;
