package IO::K8s::Api::Apps::V1::ControllerRevision;
# ABSTRACT: ControllerRevision implements an immutable snapshot of state data.
our $VERSION = '1.006';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ControllerRevision implements an immutable snapshot of state data. Clients are responsible for serializing and deserializing the objects that contain their internal state. Once a ControllerRevision has been successfully created, it can not be updated. The API Server will fail validation of all requests that attempt to mutate the Data field. ControllerRevisions may, however, be deleted. Note that, due to its use by both the DaemonSet and StatefulSet controllers for update and rollback, this object is beta. However, it may be subject to name and representation changes in future releases, and clients should not depend on its stability. It is primarily for internal use by controllers.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s data => { Str => 1 };

=attr data

Data is the serialized representation of the state.


=cut

k8s revision => Int, 'required';

=attr revision

Revision indicates the revision of the state represented by Data.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#controllerrevision-v1-apps>


=cut
1;
