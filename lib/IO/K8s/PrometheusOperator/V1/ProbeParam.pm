package IO::K8s::PrometheusOperator::V1::ProbeParam;
# ABSTRACT: ProbeParam defines specification of extra parameters for a Probe.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name   => Str, { required => 'schema' };
k8s values => [Str];

=attr name

name defines the parameter name

=cut

=attr values

values defines the parameter values

=cut

1;
