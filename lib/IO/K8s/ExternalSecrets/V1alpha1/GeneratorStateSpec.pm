package IO::K8s::ExternalSecrets::V1alpha1::GeneratorStateSpec;
# ABSTRACT: GeneratorStateSpec defines the desired state of a generator state resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s garbageCollectionDeadline => Time;
k8s resource                  => Str, { required => 'schema', preserve_unknown => 1 };
k8s state                     => Str, { required => 'schema', preserve_unknown => 1 };

=attr garbageCollectionDeadline

GarbageCollectionDeadline is the time after which the generator state
will be deleted.
It is set by the controller which creates the generator state and
can be set configured by the user.
If the garbage collection deadline is not set the generator state will not be deleted.

=cut

=attr resource

Resource is the generator manifest that produced the state.
It is a snapshot of the generator manifest at the time the state was produced.
This manifest will be used to delete the resource. Any configuration that is referenced
in the manifest should be available at the time of garbage collection. If that is not the case deletion will
be blocked by a finalizer.

=cut

=attr state

State is the state that was produced by the generator implementation.

=cut

1;
