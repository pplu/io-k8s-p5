package IO::K8s::ExternalSecrets::V1::ConfigMapReference;
# ABSTRACT: credConfig holds the configmap reference containing the GCP external account credential configuration in JSON format and the key name containing the json data.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key       => Str, { required => 'schema', pattern => qr/^[-._a-zA-Z0-9]+$/ };
k8s name      => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr key

key name holding the external account credential config.

=cut

=attr name

name of the configmap.

=cut

=attr namespace

namespace in which the configmap exists. If empty, configmap will looked up in local namespace.

=cut

1;
