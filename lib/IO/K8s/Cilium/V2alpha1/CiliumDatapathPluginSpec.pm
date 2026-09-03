package IO::K8s::Cilium::V2alpha1::CiliumDatapathPluginSpec;
# ABSTRACT: CiliumDatapathPluginSpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s attachmentPolicy => Str, { required => 'schema', enum => [qw(Always BestEffort)] };
k8s version          => Str, { required => 'schema' };

=attr attachmentPolicy

AttachmentPolicy dictates how Cilium behaves when it cannot talk to
a plugin.

=cut

=attr version

Version is an opaque string used to indicate the datapath plugin version.
Update this when deploying a new version of a datapath plugin to trigger a datapath
reinitialization.

=cut

1;
