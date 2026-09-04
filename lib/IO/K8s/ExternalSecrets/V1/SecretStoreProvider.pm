package IO::K8s::ExternalSecrets::V1::SecretStoreProvider;
# ABSTRACT: Used to configure the provider.
our $VERSION = '1.108';
use utf8;
use IO::K8s::Resource;

k8s akeyless                       => '+IO::K8s::ExternalSecrets::V1::AkeylessProvider';
k8s aws                            => '+IO::K8s::ExternalSecrets::V1::AWSProvider';
k8s azurekv                        => '+IO::K8s::ExternalSecrets::V1::AzureKVProvider';
k8s barbican                       => '+IO::K8s::ExternalSecrets::V1::BarbicanProvider';
k8s beyondtrust                    => '+IO::K8s::ExternalSecrets::V1::BeyondtrustProvider';
k8s beyondtrustworkloadcredentials => '+IO::K8s::ExternalSecrets::V1::BeyondtrustWorkloadCredentialsProvider';
k8s bitwardensecretsmanager        => '+IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerProvider';
k8s chef                           => '+IO::K8s::ExternalSecrets::V1::ChefProvider';
k8s cloudrusm                      => '+IO::K8s::ExternalSecrets::V1::CloudruSMProvider';
k8s conjur                         => '+IO::K8s::ExternalSecrets::V1::ConjurProvider';
k8s crd                            => '+IO::K8s::ExternalSecrets::V1::CRDProvider';
k8s delinea                        => '+IO::K8s::ExternalSecrets::V1::DelineaProvider';
k8s doppler                        => '+IO::K8s::ExternalSecrets::V1::DopplerProvider';
k8s dvls                           => '+IO::K8s::ExternalSecrets::V1::DVLSProvider';
k8s fake                           => '+IO::K8s::ExternalSecrets::V1::FakeProvider';
k8s fortanix                       => '+IO::K8s::ExternalSecrets::V1::FortanixProvider';
k8s gcpsm                          => '+IO::K8s::ExternalSecrets::V1::GCPSMProvider';
k8s github                         => '+IO::K8s::ExternalSecrets::V1::GithubProvider';
k8s gitlab                         => '+IO::K8s::ExternalSecrets::V1::GitlabProvider';
k8s ibm                            => '+IO::K8s::ExternalSecrets::V1::IBMProvider';
k8s infisical                      => '+IO::K8s::ExternalSecrets::V1::InfisicalProvider';
k8s keepersecurity                 => '+IO::K8s::ExternalSecrets::V1::KeeperSecurityProvider';
k8s kubernetes                     => '+IO::K8s::ExternalSecrets::V1::KubernetesProvider';
k8s nebiusmysterybox               => '+IO::K8s::ExternalSecrets::V1::NebiusMysteryboxProvider';
k8s ngrok                          => '+IO::K8s::ExternalSecrets::V1::NgrokProvider';
k8s onboardbase                    => '+IO::K8s::ExternalSecrets::V1::OnboardbaseProvider';
k8s onepassword                    => '+IO::K8s::ExternalSecrets::V1::OnePasswordProvider';
k8s onepasswordSDK                 => '+IO::K8s::ExternalSecrets::V1::OnePasswordSDKProvider';
k8s openBao                        => '+IO::K8s::ExternalSecrets::V1::OpenBaoProvider';
k8s oracle                         => '+IO::K8s::ExternalSecrets::V1::OracleProvider';
k8s ovh                            => '+IO::K8s::ExternalSecrets::V1::OvhProvider';
k8s passbolt                       => '+IO::K8s::ExternalSecrets::V1::PassboltProvider';
k8s passworddepot                  => '+IO::K8s::ExternalSecrets::V1::PasswordDepotProvider';
k8s previder                       => '+IO::K8s::ExternalSecrets::V1::PreviderProvider';
k8s pulumi                         => '+IO::K8s::ExternalSecrets::V1::PulumiProvider';
k8s scaleway                       => '+IO::K8s::ExternalSecrets::V1::ScalewayProvider';
k8s secretserver                   => '+IO::K8s::ExternalSecrets::V1::SecretServerProvider';
k8s senhasegura                    => '+IO::K8s::ExternalSecrets::V1::SenhaseguraProvider';
k8s vault                          => '+IO::K8s::ExternalSecrets::V1::VaultProvider';
k8s volcengine                     => '+IO::K8s::ExternalSecrets::V1::VolcengineProvider';
k8s webhook                        => '+IO::K8s::ExternalSecrets::V1::WebhookProvider';
k8s yandexcertificatemanager       => '+IO::K8s::ExternalSecrets::V1::YandexCertificateManagerProvider';
k8s yandexlockbox                  => '+IO::K8s::ExternalSecrets::V1::YandexLockboxProvider';

=encoding UTF-8

=cut

=attr akeyless

Akeyless configures this store to sync secrets using Akeyless Vault provider

=cut

=attr aws

AWS configures this store to sync secrets using AWS Secret Manager provider

=cut

=attr azurekv

AzureKV configures this store to sync secrets using Azure Key Vault provider

=cut

=attr barbican

Barbican configures this store to sync secrets using the OpenStack Barbican provider

=cut

=attr beyondtrust

Beyondtrust configures this store to sync secrets using Password Safe provider.

=cut

=attr beyondtrustworkloadcredentials

BeyondtrustWorkloadCredentials configures this store to sync secrets using the BeyondTrust Workload Credentials provider.

=cut

=attr bitwardensecretsmanager

BitwardenSecretsManager configures this store to sync secrets using BitwardenSecretsManager provider

=cut

=attr chef

Chef configures this store to sync secrets with chef server

=cut

=attr cloudrusm

CloudruSM configures this store to sync secrets using the Cloud.ru Secret Manager provider

=cut

=attr conjur

Conjur configures this store to sync secrets using conjur provider

=cut

=attr crd

CRD configures this store to sync secrets from arbitrary Kubernetes resources,
including both custom resources (CRDs) and core API resources. Resources are
selected by API group, version and kind, where group can be "" (empty string)
for core resources such as ConfigMap. Reading the core v1 Secret is
intentionally blocked — use the Kubernetes provider for that.

=cut

=attr delinea

Delinea DevOps Secrets Vault
https://docs.delinea.com/online-help/products/devops-secrets-vault/current

=cut

=attr doppler

Doppler configures this store to sync secrets using the Doppler provider

=cut

=attr dvls

DVLS configures this store to sync secrets using Devolutions Server provider

=cut

=attr fake

Fake configures a store with static key/value pairs

=cut

=attr fortanix

Fortanix configures this store to sync secrets using the Fortanix provider

=cut

=attr gcpsm

GCPSM configures this store to sync secrets using Google Cloud Platform Secret Manager provider

=cut

=attr github

Github configures this store to push GitHub Actions or Dependabot secrets using the GitHub API provider.
Note: This provider only supports write operations (PushSecret) and cannot fetch secrets from GitHub

=cut

=attr gitlab

GitLab configures this store to sync secrets using GitLab Variables provider

=cut

=attr ibm

IBM configures this store to sync secrets using IBM Cloud provider

=cut

=attr infisical

Infisical configures this store to sync secrets using the Infisical provider

=cut

=attr keepersecurity

KeeperSecurity configures this store to sync secrets using the KeeperSecurity provider

=cut

=attr kubernetes

Kubernetes configures this store to sync secrets using a Kubernetes cluster provider

=cut

=attr nebiusmysterybox

NebiusMysterybox configures this store to sync secrets using NebiusMysterybox provider

=cut

=attr ngrok

Ngrok configures this store to sync secrets using the ngrok provider.

=cut

=attr onboardbase

Onboardbase configures this store to sync secrets using the Onboardbase provider

=cut

=attr onepassword

OnePassword configures this store to sync secrets using the 1Password Cloud provider

=cut

=attr onepasswordSDK

OnePasswordSDK configures this store to use 1Password's new Go SDK to sync secrets.

=cut

=attr openBao

OpenBao configures this store to sync secrets using the OpenBao provider.

=cut

=attr oracle

Oracle configures this store to sync secrets using Oracle Vault provider

=cut

=attr ovh

OVHcloud configures this store to sync secrets using the OVHcloud provider.

=cut

=attr passbolt

PassboltProvider provides access to Passbolt secrets manager.
See: https://www.passbolt.com.

=cut

=attr passworddepot

PasswordDepotProvider configures a store to sync secrets with a Password Depot instance.

=cut

=attr previder

Previder configures this store to sync secrets using the Previder provider

=cut

=attr pulumi

Pulumi configures this store to sync secrets using the Pulumi provider

=cut

=attr scaleway

Scaleway configures this store to sync secrets using the Scaleway provider.

=cut

=attr secretserver

SecretServer configures this store to sync secrets using SecretServer provider
https://docs.delinea.com/online-help/secret-server/start.htm

=cut

=attr senhasegura

Senhasegura configures this store to sync secrets using senhasegura provider

=cut

=attr vault

Vault configures this store to sync secrets using the HashiCorp Vault provider.

=cut

=attr volcengine

Volcengine configures this store to sync secrets using the Volcengine provider

=cut

=attr webhook

Webhook configures this store to sync secrets using a generic templated webhook

=cut

=attr yandexcertificatemanager

YandexCertificateManager configures this store to sync secrets using Yandex Certificate Manager provider

=cut

=attr yandexlockbox

YandexLockbox configures this store to sync secrets using Yandex Lockbox provider

=cut

1;
