package IO::K8s::ExternalSecrets::V1alpha1::ECRAuthorizationTokenSpec;
# ABSTRACT: ECRAuthorizationTokenSpec defines the desired state to generate an AWS ECR authorization token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth   => '+IO::K8s::ExternalSecrets::V1::AWSAuth';
k8s region => Str, { required => 'schema' };
k8s role   => Str;
k8s scope  => Str;

=attr auth

Auth defines how to authenticate with AWS

=cut

=attr region

Region specifies the region to operate in.

=cut

=attr role

You can assume a role before making calls to the
desired AWS service.

=cut

=attr scope

Scope specifies the ECR service scope.
Valid options are private and public.

=cut

1;
