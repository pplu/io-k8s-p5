package IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicy;
# ABSTRACT: Cilium L2 announcement policy
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliuml2announcementpolicies';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
