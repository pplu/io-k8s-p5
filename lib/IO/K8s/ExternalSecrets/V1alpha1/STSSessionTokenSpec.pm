package IO::K8s::ExternalSecrets::V1alpha1::STSSessionTokenSpec;
# ABSTRACT: STSSessionTokenSpec defines the desired state to generate an AWS STS session token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth              => '+IO::K8s::ExternalSecrets::V1::AWSAuth';
k8s region            => Str, { required => 'schema' };
k8s requestParameters => '+IO::K8s::ExternalSecrets::V1alpha1::STSSessionTokenRequestParameters';
k8s role              => Str;

=attr auth

Auth defines how to authenticate with AWS

=cut

=attr region

Region specifies the region to operate in.

=cut

=attr requestParameters

RequestParameters contains parameters that can be passed to the STS service.

=cut

=attr role

You can assume a role before making calls to the
desired AWS service.

=cut

1;
