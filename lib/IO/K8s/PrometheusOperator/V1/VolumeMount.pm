package IO::K8s::PrometheusOperator::V1::VolumeMount;
# ABSTRACT: VolumeMount describes a mounting of a Volume within a container.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mountPath         => Str, { required => 'schema' };
k8s mountPropagation  => Str;
k8s name              => Str, { required => 'schema' };
k8s readOnly          => Bool;
k8s recursiveReadOnly => Str;
k8s subPath           => Str;
k8s subPathExpr       => Str;

=attr mountPath

Path within the container at which the volume should be mounted.  Must
not contain ':'.

=cut

=attr mountPropagation

mountPropagation determines how mounts are propagated from the host
to container and the other way around.
When not set, MountPropagationNone is used.
This field is beta in 1.10.
When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified
(which defaults to None).

=cut

=attr name

This must match the Name of a Volume.

=cut

=attr readOnly

Mounted read-only if true, read-write otherwise (false or unspecified).
Defaults to false.

=cut

=attr recursiveReadOnly

RecursiveReadOnly specifies whether read-only mounts should be handled
recursively.

If ReadOnly is false, this field has no meaning and must be unspecified.

If ReadOnly is true, and this field is set to Disabled, the mount is not made
recursively read-only.  If this field is set to IfPossible, the mount is made
recursively read-only, if it is supported by the container runtime.  If this
field is set to Enabled, the mount is made recursively read-only if it is
supported by the container runtime, otherwise the pod will not be started and
an error will be generated to indicate the reason.

If this field is set to IfPossible or Enabled, MountPropagation must be set to
None (or be unspecified, which defaults to None).

If this field is not specified, it is treated as an equivalent of Disabled.

=cut

=attr subPath

Path within the volume from which the container's volume should be mounted.
Defaults to "" (volume's root).

=cut

=attr subPathExpr

Expanded path within the volume from which the container's volume should be mounted.
Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.
Defaults to "" (volume's root).
SubPathExpr and SubPath are mutually exclusive.

=cut

1;
