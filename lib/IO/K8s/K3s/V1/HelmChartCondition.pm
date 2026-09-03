package IO::K8s::K3s::V1::HelmChartCondition;
# ABSTRACT: HelmChartCondition
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s message => Str;
k8s reason  => Str;
k8s status  => Str, { required => 'schema' };
k8s type    => Str, { required => 'schema' };

=attr message

Human readable message indicating details about last transition.

=cut

=attr reason

(brief) reason for the condition's last transition.

=cut

=attr status

Status of the condition, one of True, False, Unknown.

=cut

=attr type

Type of job condition.

=cut

1;
