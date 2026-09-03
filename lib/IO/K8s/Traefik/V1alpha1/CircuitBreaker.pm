package IO::K8s::Traefik::V1alpha1::CircuitBreaker;
# ABSTRACT: CircuitBreaker holds the circuit breaker configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s checkPeriod      => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s expression       => Str;
k8s fallbackDuration => IntOrStr;
k8s recoveryDuration => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s responseCode     => Int, { minimum => 100, maximum => 599 };

=attr checkPeriod

CheckPeriod is the interval between successive checks of the circuit breaker condition (when in standby state).

=cut

=attr expression

Expression is the condition that triggers the tripped state.

=cut

=attr fallbackDuration

FallbackDuration is the duration for which the circuit breaker will wait before trying to recover (from a tripped state).

=cut

=attr recoveryDuration

RecoveryDuration is the duration for which the circuit breaker will try to recover (as soon as it is in recovering state).

=cut

=attr responseCode

ResponseCode is the status code that the circuit breaker will return while it is in the open state.

=cut

1;
