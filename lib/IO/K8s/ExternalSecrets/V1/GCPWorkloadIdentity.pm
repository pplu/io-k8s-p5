package IO::K8s::ExternalSecrets::V1::GCPWorkloadIdentity;
# ABSTRACT: Specify a service account with Workload Identity
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clusterLocation   => Str;
k8s clusterName       => Str;
k8s clusterProjectID  => Str;
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr clusterLocation

ClusterLocation is the location of the cluster
If not specified, it fetches information from the metadata server

=cut

=attr clusterName

ClusterName is the name of the cluster
If not specified, it fetches information from the metadata server

=cut

=attr clusterProjectID

ClusterProjectID is the project ID of the cluster
If not specified, it fetches information from the metadata server

=cut

=attr serviceAccountRef

ServiceAccountSelector is a reference to a ServiceAccount resource.

=cut

1;
