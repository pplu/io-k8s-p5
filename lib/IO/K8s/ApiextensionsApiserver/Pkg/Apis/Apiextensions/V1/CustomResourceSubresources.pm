package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceSubresources;
# ABSTRACT: CustomResourceSubresources defines the status and scale subresources for CustomResources.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s scale => 'Apiextensions::V1::CustomResourceSubresourceScale';

=attr scale

scale indicates the custom resource should serve a `/scale` subresource that returns an `autoscaling/v1` Scale object.

=cut

k8s status => 'Apiextensions::V1::CustomResourceSubresourceStatus';

=attr status

status indicates the custom resource should serve a `/status` subresource. When enabled: 1. requests to the custom resource primary endpoint ignore changes to the `status` stanza of the object. 2. requests to the custom resource `/status` subresource ignore changes to anything other than the `status` stanza of the object.

=cut

1;
