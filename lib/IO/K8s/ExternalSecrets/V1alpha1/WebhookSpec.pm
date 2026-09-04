package IO::K8s::ExternalSecrets::V1alpha1::WebhookSpec;
# ABSTRACT: WebhookSpec controls the behavior of the external generator. Any body parameters should be passed to the server through the parameters field.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth       => '+IO::K8s::ExternalSecrets::V1::AuthorizationProtocol';
k8s body       => Str;
k8s caBundle   => Str;
k8s caProvider => '+IO::K8s::ExternalSecrets::V1::WebhookCAProvider';
k8s headers    => { Str => 1 };
k8s method     => Str;
k8s result     => '+IO::K8s::ExternalSecrets::V1::WebhookResult', { required => 'schema' };
k8s secrets    => ['+IO::K8s::ExternalSecrets::V1alpha1::WebhookSecret'];
k8s timeout    => Str;
k8s url        => Str, { required => 'schema' };

=attr auth

Auth specifies a authorization protocol. Only one protocol may be set.

=cut

=attr body

Body

=cut

=attr caBundle

PEM encoded CA bundle used to validate webhook server certificate. Only used
if the Server URL is using HTTPS protocol. This parameter is ignored for
plain HTTP protocol connection. If not set the system root certificates
are used to validate the TLS connection.

=cut

=attr caProvider

The provider for the CA bundle to use to validate webhook server certificate.

=cut

=attr headers

Headers

=cut

=attr method

Webhook Method

=cut

=attr result

Result formatting

=cut

=attr secrets

Secrets to fill in templates
These secrets will be passed to the templating function as key value pairs under the given name

=cut

=attr timeout

Timeout

=cut

=attr url

Webhook url to call

=cut

1;
