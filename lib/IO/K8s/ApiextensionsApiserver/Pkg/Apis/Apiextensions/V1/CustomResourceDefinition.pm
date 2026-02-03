package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinition;
# ABSTRACT: CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format <.spec.name>.<.spec.group>.

use IO::K8s::APIObject;

=head1 DESCRIPTION

CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format <.spec.name>.<.spec.group>.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Apiextensions::V1::CustomResourceDefinitionSpec', 'required';

=attr spec

spec describes how the user wants the resources to appear

=cut

k8s status => 'Apiextensions::V1::CustomResourceDefinitionStatus';

=attr status

status indicates the actual state of the CustomResourceDefinition

=cut

1;
