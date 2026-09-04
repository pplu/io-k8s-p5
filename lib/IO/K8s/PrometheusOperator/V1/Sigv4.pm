package IO::K8s::PrometheusOperator::V1::Sigv4;
# ABSTRACT: sigv4 defines AWS's Signature Verification 4 for the URL.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKey          => 'Core::V1::ConfigMapKeySelector';
k8s externalId         => Str;
k8s profile            => Str;
k8s region             => Str;
k8s roleArn            => Str;
k8s secretKey          => 'Core::V1::ConfigMapKeySelector';
k8s useFIPSSTSEndpoint => Bool;

=attr accessKey

accessKey defines the AWS API key. If not specified, the environment variable
`AWS_ACCESS_KEY_ID` is used.

=cut

=attr externalId

externalId defines the external ID used when assuming an AWS role. Can only be used with roleArn.
It requires Prometheus >= v3.11.0 or Alertmanager >= v0.33.0. Currently not supported by Thanos.

=cut

=attr profile

profile defines the named AWS profile used to authenticate.

=cut

=attr region

region defines the AWS region. If blank, the region from the default credentials chain used.

=cut

=attr roleArn

roleArn defines the named AWS profile used to authenticate.

=cut

=attr secretKey

secretKey defines the AWS API secret. If not specified, the environment
variable `AWS_SECRET_ACCESS_KEY` is used.

=cut

=attr useFIPSSTSEndpoint

useFIPSSTSEndpoint defines the FIPS mode for the AWS STS endpoint.
It requires Prometheus >= v2.54.0.

=cut

1;
