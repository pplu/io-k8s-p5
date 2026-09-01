package IO::K8s::Api::Lifecycle::V1alpha1::EvictionRequest;
# ABSTRACT: EvictionRequest defines a request that should ideally result in a graceful eviction of a .spec.target (e.g. termination of a pod). The evictionrequest-controller observes intents of all EvictionRequests and transforms them into Evictions. - .spec.requester is set as a label on the Eviction for easier lookup. - Each target can have a set of responders assigned to it. Eviction objects are observed by these responders, who implement the eviction logic and update the Eviction's status with progress. There is many-to-many relationship between EvictionRequests and Evictions in general. And many-to-one if the target is a pod. If all requesters withdraw their eviction intent for a common target, the eviction will be canceled. Deleting an EvictionRequest also counts as a withdrawal. Once all EvictionRequest of a target are removed, the corresponding Evictions are eventually garbage collected.
our $VERSION = '1.108';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

EvictionRequest defines a request that should ideally result in a graceful eviction of a .spec.target (e.g. termination of a pod).

The evictionrequest-controller observes intents of all EvictionRequests and transforms them into Evictions.
  - .spec.requester is set as a label on the Eviction for easier lookup.
  - Each target can have a set of responders assigned to it. Eviction objects are observed by
    these responders, who implement the eviction logic and update the Eviction's status with
    progress.

There is many-to-many relationship between EvictionRequests and Evictions in general. And many-to-one if the target is a  pod.

If all requesters withdraw their eviction intent for a common target, the eviction will be canceled. Deleting an EvictionRequest also counts as a withdrawal. Once all EvictionRequest of a target are removed, the corresponding Evictions are eventually garbage collected.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Lifecycle::V1alpha1::EvictionRequestSpec', 'required';

=attr spec

spec defines the eviction request specification. https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Lifecycle::V1alpha1::EvictionRequestStatus';

=attr status

status represents the most recently observed status of the eviction request. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#evictionrequest-v1alpha1-lifecycle.k8s.io>


=cut
1;
