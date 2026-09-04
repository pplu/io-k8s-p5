package IO::K8s::ExternalSecrets::V1::OnboardbaseProvider;
# ABSTRACT: Onboardbase configures this store to sync secrets using the Onboardbase provider
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiHost     => Str, { required => 'schema', default => 'https://public.onboardbase.com/api/v1/' };
k8s auth        => '+IO::K8s::ExternalSecrets::V1::OnboardbaseAuthSecretRef', { required => 'schema' };
k8s environment => Str, { required => 'schema', default => 'development' };
k8s project     => Str, { required => 'schema', default => 'development' };

=attr apiHost

APIHost use this to configure the host url for the API for selfhosted installation, default is https://public.onboardbase.com/api/v1/

=cut

=attr auth

Auth configures how the Operator authenticates with the Onboardbase API

=cut

=attr environment

Environment is the name of an environmnent within a project to pull the secrets from

=cut

=attr project

Project is an onboardbase project that the secrets should be pulled from

=cut

1;
