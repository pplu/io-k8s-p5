package IO::K8s::Api::Core::V1::ComponentStatus;
# ABSTRACT: ComponentStatus (and ComponentStatusList) holds the cluster validation info. Deprecated: This API is deprecated in v1.19+
our $VERSION = '1.006';
use IO::K8s::APIObject;

=description

ComponentStatus (and ComponentStatusList) holds the cluster validation info. Deprecated: This API is deprecated in v1.19+

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s conditions => ['Core::V1::ComponentCondition'];

=attr conditions

List of component conditions observed

=cut

1;
