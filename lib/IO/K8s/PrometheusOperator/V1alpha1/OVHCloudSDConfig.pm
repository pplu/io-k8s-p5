package IO::K8s::PrometheusOperator::V1alpha1::OVHCloudSDConfig;
# ABSTRACT: OVHCloudSDConfig configurations allow retrieving scrape targets from OVHcloud's dedicated servers and VPS using their API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s applicationKey    => Str, { required => 'schema' };
k8s applicationSecret => 'Core::V1::ConfigMapKeySelector', { required => 'schema' };
k8s consumerKey       => 'Core::V1::ConfigMapKeySelector', { required => 'schema' };
k8s endpoint          => Str;
k8s refreshInterval   => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s service           => Str, { required => 'schema', enum => [qw(VPS DedicatedServer)] };

=attr applicationKey

applicationKey defines the access key to use for OVHCloud API authentication.
This is obtained from the OVHCloud API credentials at https://api.ovh.com.

=cut

=attr applicationSecret

applicationSecret defines the secret key for OVHCloud API authentication.
This contains the application secret obtained during OVHCloud API credential creation.

=cut

=attr consumerKey

consumerKey defines the consumer key for OVHCloud API authentication.
This is the third component of OVHCloud's three-key authentication system.

=cut

=attr endpoint

endpoint defines a custom API endpoint to be used.
When not specified, defaults to the standard OVHCloud API endpoint for the region.

=cut

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

=attr service

service defines the service type of the targets to retrieve.
Must be either `VPS` or `DedicatedServer` to specify which OVHCloud resources to discover.

=cut

1;
