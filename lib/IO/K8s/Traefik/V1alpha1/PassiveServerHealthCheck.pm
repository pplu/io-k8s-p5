package IO::K8s::Traefik::V1alpha1::PassiveServerHealthCheck;
# ABSTRACT: PassiveHealthCheck defines passive health checks for ExternalName services.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s failureWindow     => IntOrStr;
k8s maxFailedAttempts => Int;

=attr failureWindow

FailureWindow defines the time window during which the failed attempts must occur for the server to be marked as unhealthy. It also defines for how long the server will be considered unhealthy.

=cut

=attr maxFailedAttempts

MaxFailedAttempts is the number of consecutive failed attempts allowed within the failure window before marking the server as unhealthy.

=cut

1;
