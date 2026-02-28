package IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::V1::APIService;
# ABSTRACT: APIService represents a server for a particular GroupVersion. Name must be "version.group".
our $VERSION = '1.004';
use IO::K8s::APIObject;

=head1 DESCRIPTION

APIService represents a server for a particular GroupVersion. Name must be "version.group".

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'KubeAggregator::V1::APIServiceSpec';

=attr spec

Spec contains information for locating and communicating with a server

=cut

k8s status => 'KubeAggregator::V1::APIServiceStatus';

=attr status

Status contains derived information about an API server

=cut

1;
