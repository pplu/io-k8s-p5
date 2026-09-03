package IO::K8s::CertManager::V1::ChallengeStatus;
# ABSTRACT: ChallengeStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s presented   => Bool;
k8s presentedAt => Time;
k8s processing  => Bool;
k8s reason      => Str;
k8s state       => Str, { enum => [qw(valid ready pending processing invalid expired errored)] };

=attr presented

Presented is true once cert-manager has configured the solver resources
needed to expose this challenge's validation material.
For example, the DNS01 TXT record has been created, or the HTTP01 solver
has been configured to serve the challenge token.
This does not imply the self check is passing, that the ACME server has
validated the challenge, or that cert-manager has already accepted the
challenge with the ACME server.

=cut

=attr presentedAt

PresentedAt records when cert-manager first configured the solver
resources for this challenge. This is used by the optional delay-based
readiness logic.

=cut

=attr processing

Used to denote whether this challenge should be processed or not.
This field will only be set to true by the 'scheduling' component.
It will only be set to false by the 'challenges' controller, after the
challenge has reached a final state or timed out.
If this field is set to false, the challenge controller will not take
any more action.

=cut

=attr reason

Contains human readable information on why the Challenge is in the
current state.

=cut

=attr state

Contains the current 'state' of the challenge.
If not set, the state of the challenge is unknown.

=cut

1;
