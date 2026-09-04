package IO::K8s::ExternalSecrets::V1alpha1::QuayAccessTokenSpec;
# ABSTRACT: QuayAccessTokenSpec defines the desired state to generate a Quay access token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s robotAccount      => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };
k8s url               => Str;

=attr robotAccount

Name of the robot account you are federating with

=cut

=attr serviceAccountRef

Name of the service account you are federating with

=cut

=attr url

URL configures the Quay instance URL. Defaults to quay.io.

=cut

1;
