package IO::K8s::Api::Core::V1::ResourceQuotaStatus;
# ABSTRACT: ResourceQuotaStatus defines the enforced hard limits and observed use.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hard => { Quantity => 1 };

=attr hard

Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/

=cut

k8s used => { Quantity => 1 };

=attr used

Used is the current observed total usage of the resource in the namespace.

=cut

1;
