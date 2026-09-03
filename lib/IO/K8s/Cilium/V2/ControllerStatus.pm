package IO::K8s::Cilium::V2::ControllerStatus;
# ABSTRACT: ControllerStatus is the status of a failing controller.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s configuration => '+IO::K8s::Cilium::V2::ControllerStatusConfiguration';
k8s name          => Str;
k8s status        => '+IO::K8s::Cilium::V2::ControllerStatusStatus';
k8s uuid          => Str;

=attr configuration

Configuration is the controller configuration

=cut

=attr name

Name is the name of the controller

=cut

=attr status

Status is the status of the controller

=cut

=attr uuid

UUID is the UUID of the controller

=cut

1;
