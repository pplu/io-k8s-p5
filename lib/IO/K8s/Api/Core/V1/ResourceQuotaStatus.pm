package IO::K8s::Api::Core::V1::ResourceQuotaStatus;
# ABSTRACT: ResourceQuotaStatus defines the enforced hard limits and observed use.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s hard => { Str => 1 };

=attr hard

Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/

=cut

k8s used => { Str => 1 };

=attr used

Used is the current observed total usage of the resource in the namespace.

=cut

1;
