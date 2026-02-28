package IO::K8s::Api::Core::V1::AppArmorProfile;
# ABSTRACT: AppArmorProfile defines a pod or container's AppArmor settings.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s localhostProfile => Str;

=attr localhostProfile

localhostProfile indicates a profile loaded on the node that should be used. The profile must be preconfigured on the node to work. Must match the loaded name of the profile. Must be set if and only if type is "Localhost".

=cut

k8s type => Str, 'required';

=attr type

type indicates which kind of AppArmor profile will be applied. Valid options are:
  Localhost - a profile pre-loaded on the node.
  RuntimeDefault - the container runtime's default profile.
  Unconfined - no AppArmor enforcement.

=cut

1;
