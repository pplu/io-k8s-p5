package IO::K8s::ExternalSecrets::V1::VaultCheckAndSet;
# ABSTRACT: CheckAndSet defines the Check-And-Set (CAS) settings for PushSecret operations.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s required => Bool;

=attr required

Required when true, all write operations must include a check-and-set parameter.
This helps prevent unintentional overwrites of secrets.

=cut

1;
