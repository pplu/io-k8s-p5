package IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::V1::ServiceReference;
# ABSTRACT: ServiceReference holds a reference to Service.legacy.k8s.io
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str;

=attr name

Name is the name of the service

=cut

k8s namespace => Str;

=attr namespace

Namespace is the namespace of the service

=cut

k8s port => Int;

=attr port

If specified, the port on the service that hosting webhook. Default to 443 for backward compatibility. `port` should be a valid port number (1-65535, inclusive).

=cut

1;
