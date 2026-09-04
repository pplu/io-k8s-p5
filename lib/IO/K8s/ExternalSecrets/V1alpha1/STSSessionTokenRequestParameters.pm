package IO::K8s::ExternalSecrets::V1alpha1::STSSessionTokenRequestParameters;
# ABSTRACT: RequestParameters contains parameters that can be passed to the STS service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serialNumber    => Str;
k8s sessionDuration => Int;
k8s tokenCode       => Str;

=attr serialNumber

SerialNumber is the identification number of the MFA device that is associated with the IAM user who is making
the GetSessionToken call.
Possible values: hardware device (such as GAHT12345678) or an Amazon Resource Name (ARN) for a virtual device
(such as arn:aws:iam::123456789012:mfa/user)

=cut

=attr sessionDuration

No description in the upstream schema.

=cut

=attr tokenCode

TokenCode is the value provided by the MFA device, if MFA is required.

=cut

1;
