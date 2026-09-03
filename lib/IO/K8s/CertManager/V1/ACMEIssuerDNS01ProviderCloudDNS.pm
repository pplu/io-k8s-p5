package IO::K8s::CertManager::V1::ACMEIssuerDNS01ProviderCloudDNS;
# ABSTRACT: Use the Google Cloud DNS API to manage DNS01 challenge records.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hostedZoneName          => Str;
k8s project                 => Str, { required => 'schema' };
k8s serviceAccountSecretRef => '+IO::K8s::CertManager::V1::SecretKeySelector';

=attr hostedZoneName

HostedZoneName is an optional field that tells cert-manager in which
Cloud DNS zone the challenge record has to be created.
If left empty cert-manager will automatically choose a zone.

=cut

=attr project

No description in the upstream schema.

=cut

=attr serviceAccountSecretRef

A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
