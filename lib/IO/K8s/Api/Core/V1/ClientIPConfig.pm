package IO::K8s::Api::Core::V1::ClientIPConfig;
# ABSTRACT: ClientIPConfig represents the configurations of Client IP based session affinity.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s timeoutSeconds => Int;

=attr timeoutSeconds

timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP". Default value is 10800(for 3 hours).

=cut

1;
