package IO::K8s::PrometheusOperator::V1::AzureOAuth;
# ABSTRACT: oauth defines the oauth config that is being used to authenticate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId     => Str, { required => 'schema' };
k8s clientSecret => 'Core::V1::ConfigMapKeySelector', { required => 'schema' };
k8s tenantId     => Str, { required => 'schema', pattern => qr/^[0-9a-zA-Z-.]+$/ };

=attr clientId

clientId defines the clientId of the Azure Active Directory application that is being used to authenticate.

=cut

=attr clientSecret

clientSecret specifies a key of a Secret containing the client secret of the Azure Active Directory application that is being used to authenticate.

=cut

=attr tenantId

tenantId is the tenant ID of the Azure Active Directory application that is being used to authenticate.

=cut

1;
