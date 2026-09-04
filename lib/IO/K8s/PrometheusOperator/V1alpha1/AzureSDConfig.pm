package IO::K8s::PrometheusOperator::V1alpha1::AzureSDConfig;
# ABSTRACT: AzureSDConfig allow retrieving scrape targets from Azure VMs.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authenticationMethod => Str, { enum => [qw(OAuth ManagedIdentity SDK WorkloadIdentity)] };
k8s authorization        => '+IO::K8s::PrometheusOperator::V1alpha1::SafeAuthorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1alpha1::BasicAuth';
k8s clientID             => Str;
k8s clientSecret         => 'Core::V1::ConfigMapKeySelector';
k8s enableHTTP2          => Bool;
k8s environment          => Str;
k8s followRedirects      => Bool;
k8s noProxy              => Str;
k8s oauth2               => '+IO::K8s::PrometheusOperator::V1alpha1::OAuth2';
k8s port                 => Int, { minimum => 0, maximum => 65535 };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s refreshInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s resourceGroup        => Str;
k8s subscriptionID       => Str, { required => 'schema' };
k8s tenantID             => Str;
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';

=attr authenticationMethod

authenticationMethod defines the authentication method, either `OAuth` or `ManagedIdentity` or `SDK`.
See https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview
SDK authentication method uses environment variables by default.
See https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication

=cut

=attr authorization

authorization defines the authorization header configuration to authenticate against the target HTTP endpoint.
Cannot be set at the same time as `oAuth2`, or `basicAuth`.

=cut

=attr basicAuth

basicAuth defines the information to authenticate against the target HTTP endpoint.
More info: https://prometheus.io/docs/operating/configuration/#endpoints
Cannot be set at the same time as `authorization`, or `oAuth2`.

=cut

=attr clientID

clientID defines client ID. Only required with the OAuth authentication method.

=cut

=attr clientSecret

clientSecret defines client secret. Only required with the OAuth authentication method.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.

=cut

=attr environment

environment defines the Azure environment.

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr oauth2

oauth2 defines the configuration to use on every scrape request.

=cut

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.

=cut

=attr proxyConnectHeader

proxyConnectHeader optionally specifies headers to send to
proxies during CONNECT requests.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr proxyFromEnvironment

proxyFromEnvironment defines whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr proxyUrl

proxyUrl defines the HTTP proxy server to use.

=cut

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

=attr resourceGroup

resourceGroup defines resource group name. Limits discovery to this resource group.
Requires  Prometheus v2.35.0 and above

=cut

=attr subscriptionID

subscriptionID defines subscription ID. Always required.

=cut

=attr tenantID

tenantID defines tenant ID. Only required with the OAuth authentication method.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration applying to the target HTTP endpoint.

=cut

1;
