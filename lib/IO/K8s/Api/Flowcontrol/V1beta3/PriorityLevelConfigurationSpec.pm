package IO::K8s::Api::Flowcontrol::V1beta3::PriorityLevelConfigurationSpec;
# ABSTRACT: PriorityLevelConfigurationSpec specifies the configuration of a priority level.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s exempt => 'Flowcontrol::V1beta3::ExemptPriorityLevelConfiguration';

=attr exempt

C<exempt> specifies how requests are handled for an exempt priority level. This field MUST be empty if C<type> is C<"Limited">. This field MAY be non-empty if C<type> is C<"Exempt">. If empty and C<type> is C<"Exempt"> then the default values for C<ExemptPriorityLevelConfiguration> apply.

=cut

k8s limited => 'Flowcontrol::V1beta3::LimitedPriorityLevelConfiguration';

=attr limited

C<limited> specifies how requests are handled for a Limited priority level. This field must be non-empty if and only if C<type> is C<"Limited">.

=cut

k8s type => Str, 'required';

=attr type

C<type> indicates whether this priority level is subject to limitation on request execution. A value of C<"Exempt"> means that requests of this priority level are not subject to a limit (and thus are never queued) and do not detract from the capacity made available to other priority levels. A value of C<"Limited"> means that (a) requests of this priority level _are_ subject to limits and (b) some of the server's limited capacity is made available exclusively to this priority level. Required.

=cut

1;
