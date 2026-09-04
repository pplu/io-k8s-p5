package IO::K8s::PrometheusOperator::V1::PersistentVolumeClaimTemplate;
# ABSTRACT: Will be used to create a stand-alone PVC to provision the volume.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s metadata => { Str => 1 };
k8s spec     => 'Core::V1::PersistentVolumeClaimSpec', { required => 'schema' };

=attr metadata

May contain labels and annotations that will be copied into the PVC
when creating it. No other fields are allowed and will be rejected during
validation.

=cut

=attr spec

The specification for the PersistentVolumeClaim. The entire content is
copied unchanged into the PVC that gets created from this
template. The same fields as in a PersistentVolumeClaim
are also valid here.

=cut

1;
