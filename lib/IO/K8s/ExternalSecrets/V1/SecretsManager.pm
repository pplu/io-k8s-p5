package IO::K8s::ExternalSecrets::V1::SecretsManager;
# ABSTRACT: SecretsManager defines how the provider behaves when interacting with AWS SecretsManager
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s forceDeleteWithoutRecovery => Bool;
k8s recoveryWindowInDays       => Int;

=attr forceDeleteWithoutRecovery

Specifies whether to delete the secret without any recovery window. You
can't use both this parameter and RecoveryWindowInDays in the same call.
If you don't use either, then by default Secrets Manager uses a 30 day
recovery window.
see: https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-ForceDeleteWithoutRecovery

=cut

=attr recoveryWindowInDays

The number of days from 7 to 30 that Secrets Manager waits before
permanently deleting the secret. You can't use both this parameter and
ForceDeleteWithoutRecovery in the same call. If you don't use either,
then by default Secrets Manager uses a 30-day recovery window.
see: https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-RecoveryWindowInDays

=cut

1;
