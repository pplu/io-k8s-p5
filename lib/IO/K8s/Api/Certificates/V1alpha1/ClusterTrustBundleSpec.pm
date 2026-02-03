package IO::K8s::Api::Certificates::V1alpha1::ClusterTrustBundleSpec;
# ABSTRACT: ClusterTrustBundleSpec contains the signer and trust anchors.

use IO::K8s::Resource;

k8s signerName => Str;

=attr signerName

signerName indicates the associated signer, if any.

In order to create or update a ClusterTrustBundle that sets signerName, you must have the following cluster-scoped permission: group=certificates.k8s.io resource=signers resourceName=<the signer name> verb=attest.

If signerName is not empty, then the ClusterTrustBundle object must be named with the signer name as a prefix (translating slashes to colons). For example, for the signer name C<example.com/foo>, valid ClusterTrustBundle object names include C<example.com:foo:abc> and C<example.com:foo:v1>.

If signerName is empty, then the ClusterTrustBundle object's name must not have such a prefix.

List/watch requests for ClusterTrustBundles can filter on this field using a C<spec.signerName=NAME> field selector.

=cut

k8s trustBundle => Str, 'required';

=attr trustBundle

trustBundle contains the individual X.509 trust anchors for this bundle, as PEM bundle of PEM-wrapped, DER-formatted X.509 certificates.

The data must consist only of PEM certificate blocks that parse as valid X.509 certificates.  Each certificate must include a basic constraints extension with the CA bit set.  The API server will reject objects that contain duplicate certificates, or that use PEM block headers.

Users of ClusterTrustBundles, including Kubelet, are free to reorder and deduplicate certificate blocks in this file according to their own logic, as well as to drop PEM block headers and inter-block data.

=cut

1;
