package IO::K8s::Api::Core::V1::QuobyteVolumeSource;
# ABSTRACT: Represents a Quobyte mount that lasts the lifetime of a pod. Quobyte volumes do not support ownership management or SELinux relabeling.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s group => Str;

=attr group

group to map volume access to Default is no group

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false.

=cut

k8s registry => Str, 'required';

=attr registry

registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes

=cut

k8s tenant => Str;

=attr tenant

tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin

=cut

k8s user => Str;

=attr user

user to map volume access to Defaults to serivceaccount user

=cut

k8s volume => Str, 'required';

=attr volume

volume is a string that references an already created Quobyte volume by name.

=cut

1;
