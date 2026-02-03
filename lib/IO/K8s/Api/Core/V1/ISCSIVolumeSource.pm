package IO::K8s::Api::Core::V1::ISCSIVolumeSource;
# ABSTRACT: Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.

use IO::K8s::Resource;

k8s chapAuthDiscovery => Bool;

=attr chapAuthDiscovery

chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication

=cut

k8s chapAuthSession => Bool;

=attr chapAuthSession

chapAuthSession defines whether support iSCSI Session CHAP authentication

=cut

k8s fsType => Str;

=attr fsType

fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi

=cut

k8s initiatorName => Str;

=attr initiatorName

initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.

=cut

k8s iqn => Str, 'required';

=attr iqn

iqn is the target iSCSI Qualified Name.

=cut

k8s iscsiInterface => Str;

=attr iscsiInterface

iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).

=cut

k8s lun => Int, 'required';

=attr lun

lun represents iSCSI Target Lun number.

=cut

k8s portals => [Str];

=attr portals

portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.

=cut

k8s secretRef => 'Core::V1::LocalObjectReference';

=attr secretRef

secretRef is the CHAP Secret for iSCSI target and initiator authentication

=cut

k8s targetPortal => Str, 'required';

=attr targetPortal

targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).

=cut

1;
