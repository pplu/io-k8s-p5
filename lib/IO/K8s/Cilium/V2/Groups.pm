package IO::K8s::Cilium::V2::Groups;
# ABSTRACT: Groups allows referencing CIDRs that are resolved from an external integration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s aws => '+IO::K8s::Cilium::V2::AWSGroup';

=attr aws

AWSGroup is an structure that can be used to whitelisting information from AWS integration

=cut

1;
