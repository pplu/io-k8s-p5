package IO::K8s::Cilium::V2::ControllerStatusConfiguration;
# ABSTRACT: Configuration is the controller configuration
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'error-retry'      => Bool;
k8s 'error-retry-base' => Int;
k8s interval           => Int;

=attr error-retry

Retry on error

=cut

=attr error-retry-base

Base error retry back-off time
Format: duration

=cut

=attr interval

Regular synchronization interval
Format: duration

=cut

1;
