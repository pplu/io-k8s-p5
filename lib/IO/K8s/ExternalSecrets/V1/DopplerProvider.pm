package IO::K8s::ExternalSecrets::V1::DopplerProvider;
# ABSTRACT: Doppler configures this store to sync secrets using the Doppler provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s auth            => '+IO::K8s::ExternalSecrets::V1::DopplerAuth', { required => 'schema' };
k8s config          => Str;
k8s format          => Str, { enum => [qw(json dotnet-json env yaml docker)] };
k8s nameTransformer => Str, { enum => [qw(upper-camel camel lower-snake tf-var dotnet-env lower-kebab)] };
k8s project         => Str;

=attr auth

Auth configures how the Operator authenticates with the Doppler API

=cut

=attr config

Doppler config (required if not using a Service Token)

=cut

=attr format

Format enables the downloading of secrets as a file (string)

=cut

=attr nameTransformer

Environment variable compatible name transforms that change secret names to a different format

=cut

=attr project

Doppler project (required if not using a Service Token)

=cut

1;
