package IO::K8s::Cilium::V2::CiliumNetworkPolicyNodeStatus;
# ABSTRACT: CiliumNetworkPolicyNodeStatus is the status of a Cilium policy rule for a specific node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s annotations         => { Str => 1 };
k8s enforcing           => Bool;
k8s error               => Str;
k8s lastUpdated         => Time;
k8s localPolicyRevision => Int;
k8s ok                  => Bool;

=attr annotations

Annotations corresponds to the Annotations in the ObjectMeta of the CNP
that have been realized on the node for CNP. That is, if a CNP has been
imported and has been assigned annotation X=Y by the user,
Annotations in CiliumNetworkPolicyNodeStatus will be X=Y once the
CNP that was imported corresponding to Annotation X=Y has been realized on
the node.

=cut

=attr enforcing

Enforcing is set to true once all endpoints present at the time the
policy has been imported are enforcing this policy.

=cut

=attr error

Error describes any error that occurred when parsing or importing the
policy, or realizing the policy for the endpoints to which it applies
on the node.

=cut

=attr lastUpdated

LastUpdated contains the last time this status was updated

=cut

=attr localPolicyRevision

Revision is the policy revision of the repository which first implemented
this policy.

=cut

=attr ok

OK is true when the policy has been parsed and imported successfully
into the in-memory policy repository on the node.

=cut

1;
