package IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicy;
# ABSTRACT: CiliumL2AnnouncementPolicy is a Kubernetes third-party resource which is used to defined which nodes should announce what services on the L2 network.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliuml2announcementpolicies';

k8s spec   => '+IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicySpec';
k8s status => '+IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicyStatus';

=attr spec

Spec is a human readable description of a L2 announcement policy

=cut

=attr status

Status is the status of the policy.

=cut

1;
