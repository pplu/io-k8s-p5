package IO::K8s::Api::Core::V1::ClusterTrustBundleProjection;
# ABSTRACT: ClusterTrustBundleProjection describes how to select a set of ClusterTrustBundle objects and project their contents into the pod filesystem.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s labelSelector => 'Meta::V1::LabelSelector';

=attr labelSelector

Select all ClusterTrustBundles that match this label selector.  Only has effect if signerName is set.  Mutually-exclusive with name.  If unset, interpreted as "match nothing".  If set but empty, interpreted as "match everything".

=cut

k8s name => Str;

=attr name

Select a single ClusterTrustBundle by object name.  Mutually-exclusive with signerName and labelSelector.

=cut

k8s optional => Bool;

=attr optional

If true, don't block pod startup if the referenced ClusterTrustBundle(s) aren't available.  If using name, then the named ClusterTrustBundle is allowed not to exist.  If using signerName, then the combination of signerName and labelSelector is allowed to match zero ClusterTrustBundles.

=cut

k8s path => Str, 'required';

=attr path

Relative path from the volume root to write the bundle.

=cut

k8s signerName => Str;

=attr signerName

Select all ClusterTrustBundles that match this signer name. Mutually-exclusive with name.  The contents of all selected ClusterTrustBundles will be unified and deduplicated.

=cut

1;
