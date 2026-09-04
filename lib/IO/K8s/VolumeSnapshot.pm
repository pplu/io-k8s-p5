package IO::K8s::VolumeSnapshot;
# ABSTRACT: VolumeSnapshot CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v8.6.0' }  # kubernetes-csi/external-snapshotter

# Upstream CRD manifests for the pinned upstream_version, consumed by
# maint/crd-drift-check.pl. Data only -- no fetching happens here. `base`
# + each `files` entry is the raw manifest URL; the checker caches each
# under spec/crd/VolumeSnapshot/ (path separators flattened to '_').
sub crd_sources {
    my $v = __PACKAGE__->upstream_version;
    return {
        status => 'ok',
        base   => "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/$v/client/config/crd",
        files  => [
            'snapshot.storage.k8s.io_volumesnapshotclasses.yaml',
            'snapshot.storage.k8s.io_volumesnapshotcontents.yaml',
            'snapshot.storage.k8s.io_volumesnapshots.yaml',
        ],
    };
}

sub resource_map {
    return {
        VolumeSnapshot        => 'VolumeSnapshot::V1::VolumeSnapshot',
        VolumeSnapshotClass   => 'VolumeSnapshot::V1::VolumeSnapshotClass',
        VolumeSnapshotContent => 'VolumeSnapshot::V1::VolumeSnapshotContent',
    };
}

1;

__END__

=head1 SYNOPSIS

    my $k8s = IO::K8s->new(with => ['IO::K8s::VolumeSnapshot']);

    my $vs = $k8s->new_object('VolumeSnapshot',
        metadata => { name => 'my-snapshot', namespace => 'default' },
        spec => { source => { persistentVolumeClaimName => 'my-pvc' } },
    );

    print $vs->to_yaml;

=head1 DESCRIPTION

Resource map provider for the L<external-snapshotter|https://github.com/kubernetes-csi/external-snapshotter>
VolumeSnapshot Custom Resource Definitions. Registers 3 resource_map
entries covering C<snapshot.storage.k8s.io/v1>, matching upstream
external-snapshotter v8.6.0.

Modeled to full depth: every Kind's C<spec> and, where upstream declares
one, C<status> is a typed object graph of further
C<IO::K8s::VolumeSnapshot::V1::*> classes, one per upstream Go structure,
named after the upstream Go types -- 3 Kinds, 7 further classes.
L<IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError> is shared between
L<IO::K8s::VolumeSnapshot::V1::VolumeSnapshotStatus> and
L<IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentStatus>, matching how
upstream declares one Go type for both. C<VolumeSnapshotContentSpec>'s
C<volumeSnapshotRef> reuses the stock
L<IO::K8s::Api::Core::V1::ObjectReference>, not a re-modeled copy.
C<VolumeSnapshotClass> has no C<spec>/C<status> wrapper upstream -- its
fields (C<driver>, C<deletionPolicy>, C<parameters>) sit directly on the
Kind, the same shape as L<IO::K8s::Cilium::V2::CiliumIdentity>.

Only the storage C<v1> API version is modeled; the deprecated, non-served
C<v1beta1> track that upstream still ships alongside it is not.

C<VolumeSnapshot> is namespace-scoped; C<VolumeSnapshotClass> and
C<VolumeSnapshotContent> are cluster-scoped, matching each Kind's
C<spec.scope> in the upstream CRD manifests.

v8.6.0 also promoted C<VolumeGroupSnapshot>/C<VolumeGroupSnapshotClass>/
C<VolumeGroupSnapshotContent> (group C<groupsnapshot.storage.k8s.io/v1>)
to GA. Those are not modeled by this provider -- see karr for a possible
follow-up.

Not loaded by default -- opt in via the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::VolumeSnapshot') >> at
runtime.

=head2 Included CRDs (snapshot.storage.k8s.io/v1)

VolumeSnapshot, VolumeSnapshotClass, VolumeSnapshotContent

=seealso

L<IO::K8s>

L<VolumeSnapshot documentation|https://kubernetes.io/docs/concepts/storage/volume-snapshots/>

L<external-snapshotter CRDs|https://github.com/kubernetes-csi/external-snapshotter/tree/v8.6.0/client/config/crd>

=cut
