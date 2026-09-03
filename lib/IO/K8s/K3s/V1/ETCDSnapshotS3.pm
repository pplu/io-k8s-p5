package IO::K8s::K3s::V1::ETCDSnapshotS3;
# ABSTRACT: ETCDSnapshotS3 holds information about the S3 storage system holding the snapshot.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bucket        => Str;
k8s bucketLookup  => Str;
k8s endpoint      => Str;
k8s endpointCA    => Str;
k8s insecure      => Bool;
k8s prefix        => Str;
k8s region        => Str;
k8s skipSSLVerify => Bool;

=attr bucket

Bucket is the bucket holding the snapshot

=cut

=attr bucketLookup

BucketLookup is the bucket lookup type, one of 'auto', 'dns', 'path'. Default if empty is 'auto'.

=cut

=attr endpoint

Endpoint is the host or host:port of the S3 service

=cut

=attr endpointCA

EndpointCA is the path on disk to the S3 service's trusted CA list. Leave empty to use the OS CA bundle.

=cut

=attr insecure

Insecure is true if the S3 service uses HTTP instead of HTTPS

=cut

=attr prefix

Prefix is the prefix in which the snapshot file is stored.

=cut

=attr region

Region is the region of the S3 service

=cut

=attr skipSSLVerify

SkipSSLVerify is true if TLS certificate verification is disabled

=cut

1;
