package IO::K8s::Api::Core::V1::ResourceHealth;
# ABSTRACT: ResourceHealth represents the health of a resource. It has the latest device health information. This is a part of KEP https://kep.k8s.io/4680 and historical health changes are planned to be added in future iterations of a KEP.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s health => Str;

=attr health

Health of the resource. can be one of:  - Healthy: operates as normal 

=cut

k8s resourceID => Str, 'required';

=attr resourceID

ResourceID is the unique identifier of the resource. See the ResourceID type for more information.

=cut

1;
