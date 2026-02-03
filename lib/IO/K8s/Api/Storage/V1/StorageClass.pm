package IO::K8s::Api::Storage::V1::StorageClass;
# ABSTRACT: StorageClass describes the parameters for a class of storage for which PersistentVolumes can be dynamically provisioned. StorageClasses are non-namespaced; the name of the storage class according to etcd is in ObjectMeta.Name.

use IO::K8s::APIObject;

=head1 DESCRIPTION

StorageClass describes the parameters for a class of storage for which PersistentVolumes can be dynamically provisioned.

StorageClasses are non-namespaced; the name of the storage class according to etcd is in ObjectMeta.Name.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s allowVolumeExpansion => Bool;

=attr allowVolumeExpansion

allowVolumeExpansion shows whether the storage class allow volume expand.

=cut

k8s allowedTopologies => ['Core::V1::TopologySelectorTerm'];

=attr allowedTopologies

allowedTopologies restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.

=cut

k8s mountOptions => [Str];

=attr mountOptions

mountOptions controls the mountOptions for dynamically provisioned PersistentVolumes of this storage class. e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.

=cut

k8s parameters => { Str => 1 };

=attr parameters

parameters holds the parameters for the provisioner that should create volumes of this storage class.

=cut

k8s provisioner => Str, 'required';

=attr provisioner

provisioner indicates the type of the provisioner.

=cut

k8s reclaimPolicy => Str;

=attr reclaimPolicy

reclaimPolicy controls the reclaimPolicy for dynamically provisioned PersistentVolumes of this storage class. Defaults to Delete.

=cut

k8s volumeBindingMode => Str;

=attr volumeBindingMode

volumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound. When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.

=cut

1;
