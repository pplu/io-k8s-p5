package IO::K8s::Api::Core::V1::ContainerResizePolicy;
# ABSTRACT: ContainerResizePolicy represents resource resize policy for the container.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s resourceName => Str, 'required';

=attr resourceName

Name of the resource to which this resource resize policy applies. Supported values: cpu, memory.

=cut

k8s restartPolicy => Str, 'required';

=attr restartPolicy

Restart policy to apply when specified resource is resized. If not specified, it defaults to NotRequired.

=cut

1;
