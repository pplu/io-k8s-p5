package IO::K8s::Api::Core::V1::FileKeySelector;
# ABSTRACT: FileKeySelector selects a key of the env file.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

The key within the env file. An invalid key will prevent the pod from starting. The keys defined within a source may consist of any printable ASCII characters except '='. During Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.

=cut

k8s optional => Bool;

=attr optional

Specify whether the file or its key must be defined. If the file or key does not exist, then the env var is not published. If optional is set to true and the specified key does not exist, the environment variable will not be set in the Pod's containers.

If optional is set to false and the specified key does not exist, an error will be returned during Pod creation.

=cut

k8s path => Str, 'required';

=attr path

The path within the volume from which to select the file. Must be relative and may not contain the '..' path or start with '..'.

=cut

k8s volumeName => Str, 'required';

=attr volumeName

The name of the volume mount containing the env file.

=cut

1;
