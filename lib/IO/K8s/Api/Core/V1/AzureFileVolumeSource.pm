package IO::K8s::Api::Core::V1::AzureFileVolumeSource;
# ABSTRACT: AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s readOnly => Bool;

=attr readOnly

readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s secretName => Str, 'required';

=attr secretName

secretName is the  name of secret that contains Azure Storage Account Name and Key

=cut

k8s shareName => Str, 'required';

=attr shareName

shareName is the azure share Name

=cut

1;
