package IO::K8s::PrometheusOperator::V1alpha1::BasicAuth;
# ABSTRACT: basicAuth defines information to use on every scrape request.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s password => 'Core::V1::ConfigMapKeySelector';
k8s username => 'Core::V1::ConfigMapKeySelector';

=attr password

password defines a key of a Secret containing the password for
authentication.

=cut

=attr username

username defines a key of a Secret containing the username for
authentication.

=cut

1;
