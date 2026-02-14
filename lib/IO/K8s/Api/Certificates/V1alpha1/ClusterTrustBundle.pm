package IO::K8s::Api::Certificates::V1alpha1::ClusterTrustBundle;
# ABSTRACT: ClusterTrustBundle is a cluster-scoped container for X.509 trust anchors (root certificates).
our $VERSION = '1.002';
use IO::K8s::APIObject;

=description

ClusterTrustBundle is a cluster-scoped container for X.509 trust anchors (root certificates).

ClusterTrustBundle objects are considered to be readable by any authenticated user in the cluster, because they can be mounted by pods using the C<clusterTrustBundle> projection.  All service accounts have read access to ClusterTrustBundles by default.  Users who only have namespace-level access to a cluster can read ClusterTrustBundles by impersonating a serviceaccount that they have access to.

It can be optionally associated with a particular assigner, in which case it contains one valid set of trust anchors for that signer. Signers may have multiple associated ClusterTrustBundles; each is an independent set of trust anchors for that signer. Admission control is used to enforce that only users with permissions on the signer can create or modify the corresponding bundle.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Certificates::V1alpha1::ClusterTrustBundleSpec', 'required';

=attr spec

spec contains the signer (if any) and trust anchors.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#clustertrustbundle-v1alpha1-certificates.k8s.io>


=cut
1;
