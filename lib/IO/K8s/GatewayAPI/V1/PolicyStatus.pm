package IO::K8s::GatewayAPI::V1::PolicyStatus;
# ABSTRACT: Status defines the current state of BackendTLSPolicy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ancestors => ['+IO::K8s::GatewayAPI::V1::PolicyAncestorStatus'], { required => 'schema' };

=attr ancestors

Ancestors is a list of ancestor resources (usually Gateways) that are
associated with the policy, and the status of the policy with respect to
each ancestor. When this policy attaches to a parent, the controller that
manages the parent and the ancestors MUST add an entry to this list when
the controller first sees the policy and SHOULD update the entry as
appropriate when the relevant ancestor is modified.

Note that choosing the relevant ancestor is left to the Policy designers;
an important part of Policy design is designing the right object level at
which to namespace this status.

Note also that implementations MUST ONLY populate ancestor status for
the Ancestor resources they are responsible for. Implementations MUST
use the ControllerName field to uniquely identify the entries in this list
that they are responsible for.

Note that to achieve this, the list of PolicyAncestorStatus structs
MUST be treated as a map with a composite key, made up of the AncestorRef
and ControllerName fields combined.

A maximum of 16 ancestors will be represented in this list. An empty list
means the Policy is not relevant for any ancestors.

If this slice is full, implementations MUST NOT add further entries.
Instead they MUST consider the policy unimplementable and signal that
on any related resources such as the ancestor that would be referenced
here. For example, if this list was full on BackendTLSPolicy, no
additional Gateways would be able to reference the Service targeted by
the BackendTLSPolicy.

=cut

1;
