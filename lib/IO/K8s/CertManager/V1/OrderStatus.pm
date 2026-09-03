package IO::K8s::CertManager::V1::OrderStatus;
# ABSTRACT: OrderStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorizations => ['+IO::K8s::CertManager::V1::ACMEAuthorization'];
k8s certificate    => Str;
k8s failureTime    => Time;
k8s finalizeURL    => Str;
k8s reason         => Str;
k8s state          => Str, { enum => [qw(valid ready pending processing invalid expired errored)] };
k8s url            => Str;

=attr authorizations

Authorizations contains data returned from the ACME server on what
authorizations must be completed in order to validate the DNS names
specified on the Order.

=cut

=attr certificate

Certificate is a copy of the PEM encoded certificate for this Order.
This field will be populated after the order has been successfully
finalized with the ACME server, and the order has transitioned to the
'valid' state.

=cut

=attr failureTime

FailureTime stores the time that this order failed.
This is used to influence garbage collection and back-off.

=cut

=attr finalizeURL

FinalizeURL of the Order.
This is used to obtain certificates for this order once it has been completed.

=cut

=attr reason

Reason optionally provides more information about a why the order is in
the current state.

=cut

=attr state

State contains the current state of this Order resource.
States 'success' and 'expired' are 'final'

=cut

=attr url

URL of the Order.
This will initially be empty when the resource is first created.
The Order controller will populate this field when the Order is first processed.
This field will be immutable after it is initially set.

=cut

1;
