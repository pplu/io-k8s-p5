package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinitionStatus;
# ABSTRACT: CustomResourceDefinitionStatus indicates the state of the CustomResourceDefinition
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s acceptedNames => 'Apiextensions::V1::CustomResourceDefinitionNames';

=attr acceptedNames

acceptedNames are the names that are actually being used to serve discovery. They may be different than the names in spec.

=cut

k8s conditions => ['Apiextensions::V1::CustomResourceDefinitionCondition'];

=attr conditions

conditions indicate state for particular aspects of a CustomResourceDefinition

=cut

k8s storedVersions => [Str];

=attr storedVersions

storedVersions lists all versions of CustomResources that were ever persisted. Tracking these versions allows a migration path for stored versions in etcd. The field is mutable so a migration controller can finish a migration to another version (ensuring no old objects are left in storage), and then remove the rest of the versions from this list. Versions may not be removed from `spec.versions` while they exist in this list.

=cut

1;
