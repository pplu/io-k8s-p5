package IO::K8s::PrometheusOperator::V1::ArbitraryFSAccessThroughSMsConfig;
# ABSTRACT: arbitraryFSAccessThroughSMs when true, ServiceMonitor, PodMonitor and Probe object are forbidden to reference arbitrary files on the file system of the 'prometheus' container.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s deny => Bool;

=attr deny

deny prevents service monitors from accessing arbitrary files on the file system.
When true, service monitors cannot use file-based configurations like BearerTokenFile
that could potentially access sensitive files. When false (default), such access is allowed.
Setting this to true enhances security by preventing potential credential theft attacks.

=cut

1;
