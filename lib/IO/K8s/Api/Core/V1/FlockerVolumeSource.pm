package IO::K8s::Api::Core::V1::FlockerVolumeSource;
# ABSTRACT: Represents a Flocker volume mounted by the Flocker agent. One and only one of datasetName and datasetUUID should be set. Flocker volumes do not support ownership management or SELinux relabeling.

use IO::K8s::Resource;

k8s datasetName => Str;

=attr datasetName

datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated

=cut

k8s datasetUUID => Str;

=attr datasetUUID

datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset

=cut

1;
