package IO::K8s::Api::Core::V1::WindowsSecurityContextOptions;
# ABSTRACT: WindowsSecurityContextOptions contain Windows-specific options and credentials.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s gmsaCredentialSpec => Str;

=attr gmsaCredentialSpec

GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field.

=cut

k8s gmsaCredentialSpecName => Str;

=attr gmsaCredentialSpecName

GMSACredentialSpecName is the name of the GMSA credential spec to use.

=cut

k8s hostProcess => Bool;

=attr hostProcess

HostProcess determines if a container should be run as a 'Host Process' container. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers). In addition, if HostProcess is true then HostNetwork must also be set to true.

=cut

k8s runAsUserName => Str;

=attr runAsUserName

The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.

=cut

1;
