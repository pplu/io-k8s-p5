package IO::K8s::Cilium::V2::AllocationIP;
# ABSTRACT: AllocationIP is an IP which is available for allocation, or already has been allocated
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s owner    => Str;
k8s resource => Str;

=attr owner

Owner is the owner of the IP. This field is set if the IP has been
allocated. It will be set to the pod name or another identifier
representing the usage of the IP

The owner field is left blank for an entry in Spec.IPAM.Pool and
filled out as the IP is used and also added to Status.IPAM.Used.

=cut

=attr resource

Resource is set for both available and allocated IPs, it represents
what resource the IP is associated with, e.g. in combination with
AWS ENI, this will refer to the ID of the ENI

=cut

1;
