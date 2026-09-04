package IO::K8s::PrometheusOperator::V1alpha1::OpenStackSDConfig;
# ABSTRACT: OpenStackSDConfig allow retrieving scrape targets from OpenStack Nova instances.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allTenants                  => Bool;
k8s applicationCredentialId     => Str;
k8s applicationCredentialName   => Str;
k8s applicationCredentialSecret => 'Core::V1::ConfigMapKeySelector';
k8s availability                => Str, { enum => [qw(Public public Admin admin Internal internal)] };
k8s domainID                    => Str;
k8s domainName                  => Str;
k8s identityEndpoint            => Str, { pattern => qr/^https?:\/\/.+$/ };
k8s password                    => 'Core::V1::ConfigMapKeySelector';
k8s port                        => Int, { minimum => 0, maximum => 65535 };
k8s projectID                   => Str;
k8s projectName                 => Str;
k8s refreshInterval             => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s region                      => Str, { required => 'schema' };
k8s role                        => Str, { required => 'schema', enum => [qw(Instance Hypervisor LoadBalancer)] };
k8s tlsConfig                   => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';
k8s userid                      => Str;
k8s username                    => Str;

=attr allTenants

allTenants defines whether the service discovery should list all instances for all projects.
It is only relevant for the 'instance' role and usually requires admin permissions.

=cut

=attr applicationCredentialId

applicationCredentialId defines the OpenStack applicationCredentialId.

=cut

=attr applicationCredentialName

applicationCredentialName defines the ApplicationCredentialID or ApplicationCredentialName fields are
required if using an application credential to authenticate. Some providers
allow you to create an application credential to authenticate rather than a
password.

=cut

=attr applicationCredentialSecret

applicationCredentialSecret defines the required field if using an application
credential to authenticate.

=cut

=attr availability

availability defines the availability of the endpoint to connect to.

=cut

=attr domainID

domainID defines The OpenStack domainID.

=cut

=attr domainName

domainName defines at most one of domainId and domainName that must be provided if using username
with Identity V3. Otherwise, either are optional.

=cut

=attr identityEndpoint

identityEndpoint defines the HTTP endpoint that is required to work with
the Identity API of the appropriate version.

=cut

=attr password

password defines the password for the Identity V2 and V3 APIs. Consult with your provider's
control panel to discover your account's preferred method of authentication.

=cut

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.

=cut

=attr projectID

projectID defines the OpenStack projectID.

=cut

=attr projectName

projectName defines an optional field for the Identity V2 API.
Some providers allow you to specify a ProjectName instead of the ProjectId.
Some require both. Your provider's authentication policies will determine
how these fields influence authentication.

=cut

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

=attr region

region defines the OpenStack Region.

=cut

=attr role

role defines the OpenStack role of entities that should be discovered.

Note: The `LoadBalancer` role requires Prometheus >= v3.2.0.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration applying to the target HTTP endpoint.

=cut

=attr userid

userid defines the OpenStack userid.

=cut

=attr username

username defines the username required if using Identity V2 API. Consult with your provider's
control panel to discover your account's username.
In Identity V3, either userid or a combination of username
and domainId or domainName are needed

=cut

1;
