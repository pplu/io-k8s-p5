package IO::K8s::ExternalSecrets::V1alpha1::GCRWorkloadIdentity;
# ABSTRACT: Specify a service account with Workload Identity
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clusterLocation   => Str, { required => 'schema' };
k8s clusterName       => Str, { required => 'schema' };
k8s clusterProjectID  => Str;
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr clusterLocation

No description in the upstream schema.

=cut

=attr clusterName

No description in the upstream schema.

=cut

=attr clusterProjectID

No description in the upstream schema.

=cut

=attr serviceAccountRef

ServiceAccountSelector is a reference to a ServiceAccount resource.

=cut

1;
