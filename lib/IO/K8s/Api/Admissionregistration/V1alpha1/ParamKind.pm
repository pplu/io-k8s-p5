package IO::K8s::Api::Admissionregistration::V1alpha1::ParamKind;
# ABSTRACT: ParamKind is a tuple of Group Kind and Version.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s apiVersion => Str;

=attr apiVersion

APIVersion is the API group version the resources belong to. In format of "group/version". Required.

=cut

k8s kind => Str;

=attr kind

Kind is the API kind the resources belong to. Required.

=cut

1;
