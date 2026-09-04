package IO::K8s::ExternalSecrets::V1alpha1::GCRAccessTokenSpec;
# ABSTRACT: GCRAccessTokenSpec defines the desired state to generate a Google Container Registry access token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth      => '+IO::K8s::ExternalSecrets::V1alpha1::GCRAuth', { required => 'schema' };
k8s projectID => Str, { required => 'schema' };

=attr auth

Auth defines the means for authenticating with GCP

=cut

=attr projectID

ProjectID defines which project to use to authenticate with

=cut

1;
