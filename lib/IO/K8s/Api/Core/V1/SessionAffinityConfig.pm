package IO::K8s::Api::Core::V1::SessionAffinityConfig;
# ABSTRACT: SessionAffinityConfig represents the configurations of session affinity.

use IO::K8s::Resource;

k8s clientIP => 'Core::V1::ClientIPConfig';

=attr clientIP

clientIP contains the configurations of Client IP based session affinity.

=cut

1;
