package IO::K8s::Api::Resource::V1alpha3::OpaqueDeviceConfiguration;
# ABSTRACT: OpaqueDeviceConfiguration contains configuration parameters for a driver in a format defined by the driver vendor.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s driver => Str, 'required';

=attr driver

Driver is used to determine which kubelet plugin needs to be passed these configuration parameters.

An admission policy provided by the driver developer could use this to decide whether it needs to validate them.

Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.

=cut

k8s parameters => { Str => 1 };

=attr parameters

Parameters can contain arbitrary data. It is the responsibility of the driver developer to handle validation and versioning. Typically this includes self-identification and a version ("kind" + "apiVersion" for Kubernetes types), with conversion between different versions.

=cut

1;
