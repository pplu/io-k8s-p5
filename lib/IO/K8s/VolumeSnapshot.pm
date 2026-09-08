package IO::K8s::VolumeSnapshot;
# ABSTRACT: VolumeSnapshot CRD resource map provider for IO::K8s
our $VERSION = '1.108';
use Moo;
with 'IO::K8s::Role::ResourceMap';

sub upstream_version { 'v8.6.0' }  # kubernetes-csi/external-snapshotter

=method upstream_version

Returns the external-snapshotter release whose CRDs this provider models.

=cut

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
            'groupsnapshot.storage.k8s.io_volumegroupsnapshotclasses.yaml',
            'groupsnapshot.storage.k8s.io_volumegroupsnapshotcontents.yaml',
            'groupsnapshot.storage.k8s.io_volumegroupsnapshots.yaml',
        ],
    };
}

=method crd_sources

Returns the six raw CRD manifest locations pinned to C<upstream_version>.

=cut

sub resource_map {
    return {
        VolumeSnapshot        => 'VolumeSnapshot::V1::VolumeSnapshot',
        VolumeSnapshotClass   => 'VolumeSnapshot::V1::VolumeSnapshotClass',
        VolumeSnapshotContent => 'VolumeSnapshot::V1::VolumeSnapshotContent',

        VolumeGroupSnapshot        => 'VolumeSnapshot::V1beta2::VolumeGroupSnapshot',
        VolumeGroupSnapshotClass   => 'VolumeSnapshot::V1beta2::VolumeGroupSnapshotClass',
        VolumeGroupSnapshotContent => 'VolumeSnapshot::V1beta2::VolumeGroupSnapshotContent',

        'groupsnapshot.storage.k8s.io/v1/VolumeGroupSnapshot'
            => 'VolumeSnapshot::V1::VolumeGroupSnapshot',
        'groupsnapshot.storage.k8s.io/v1/VolumeGroupSnapshotClass'
            => 'VolumeSnapshot::V1::VolumeGroupSnapshotClass',
        'groupsnapshot.storage.k8s.io/v1/VolumeGroupSnapshotContent'
            => 'VolumeSnapshot::V1::VolumeGroupSnapshotContent',
        'groupsnapshot.storage.k8s.io/v1beta1/VolumeGroupSnapshot'
            => 'VolumeSnapshot::V1beta1::VolumeGroupSnapshot',
        'groupsnapshot.storage.k8s.io/v1beta1/VolumeGroupSnapshotClass'
            => 'VolumeSnapshot::V1beta1::VolumeGroupSnapshotClass',
        'groupsnapshot.storage.k8s.io/v1beta1/VolumeGroupSnapshotContent'
            => 'VolumeSnapshot::V1beta1::VolumeGroupSnapshotContent',
    };
}

=method resource_map

Returns the twelve short-name and fully qualified group-version-kind routes
provided by this provider.

=cut

1;

__END__

=synopsis

    my $k8s = IO::K8s->new(with => ['IO::K8s::VolumeSnapshot']);

    my $vs = $k8s->new_object('VolumeSnapshot',
        metadata => { name => 'my-snapshot', namespace => 'default' },
        spec => { source => { persistentVolumeClaimName => 'my-pvc' } },
    );

    my $group = $k8s->new_object('VolumeGroupSnapshot',
        metadata => { name => 'database-group', namespace => 'default' },
        spec => {
            volumeGroupSnapshotClassName => 'csi-group-snapshot-class',
            source => { selector => { matchLabels => { app => 'database' } } },
        },
    );

    print $group->to_yaml;

=description

Resource-map provider for the VolumeSnapshot and VolumeGroupSnapshot Custom
Resource Definitions from the
L<external-snapshotter|https://github.com/kubernetes-csi/external-snapshotter>
project, pinned to external-snapshotter v8.6.0. Its C<crd_sources> lists the
six raw CRD manifests for that release.

The provider has 12 raw resource-map entries. The three snapshot Kinds,
C<VolumeSnapshot>, C<VolumeSnapshotClass>, and C<VolumeSnapshotContent>, are
modeled at C<snapshot.storage.k8s.io/v1>. C<VolumeSnapshot> is
namespace-scoped; C<VolumeSnapshotClass> and C<VolumeSnapshotContent> are
cluster-scoped. The deprecated, non-served C<snapshot.storage.k8s.io/v1beta1>
track that upstream ships alongside C<v1> is not modeled. Both snapshot-class
Kinds keep their upstream shape: C<driver>, C<deletionPolicy>, and
C<parameters> are direct fields rather than a C<spec>/C<status> wrapper.

The provider additionally models the three group-snapshot Kinds,
C<VolumeGroupSnapshot>, C<VolumeGroupSnapshotClass>, and
C<VolumeGroupSnapshotContent>, in all three served
C<groupsnapshot.storage.k8s.io> tracks: C<v1>, C<v1beta1>, and C<v1beta2>.
The bare group-snapshot names select their C<v1beta2> classes because
C<v1beta2> is the sole storage version. Use an explicit GVK such as
C<groupsnapshot.storage.k8s.io/v1/VolumeGroupSnapshot> or
C<groupsnapshot.storage.k8s.io/v1beta1/VolumeGroupSnapshot> to select either
of the other served tracks.

The provider models 33 group-snapshot types and 10 snapshot types.
C<VolumeGroupSnapshot> is namespace-scoped; C<VolumeGroupSnapshotClass> and
C<VolumeGroupSnapshotContent> are cluster-scoped. The group-snapshot source
reuses the stock L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector>,
and the content reference reuses L<IO::K8s::Api::Core::V1::ObjectReference>.

C<v1> and C<v1beta2> use their C<VolumeSnapshotInfo> type for
C<volumeSnapshotInfoList>; C<v1beta1> uses
C<VolumeSnapshotHandlePair> for C<volumeSnapshotHandlePairList>. All tracks
reuse L<IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError>. The
L<IO::K8s::CRD::Emitter>-rendered C<maint/crd-render> overlay does not yet
support this shared error leaf as a cross-version alias.

Not loaded by default. Opt in through the C<with> constructor parameter of
L<IO::K8s> or by calling C<< $k8s->add('IO::K8s::VolumeSnapshot') >> at
runtime.

=seealso

L<IO::K8s>

L<VolumeSnapshot documentation|https://kubernetes.io/docs/concepts/storage/volume-snapshots/>

L<external-snapshotter CRDs|https://github.com/kubernetes-csi/external-snapshotter/tree/v8.6.0/client/config/crd>

=cut
