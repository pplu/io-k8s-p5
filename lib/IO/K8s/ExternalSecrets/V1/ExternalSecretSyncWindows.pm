package IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindows;
# ABSTRACT: SyncWindows optionally restricts when periodic refreshes may occur.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kind    => Str, { required => 'schema', enum => [qw(allow deny)] };
k8s windows => ['+IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindowEntry'], { required => 'schema' };

=attr kind

Kind applies to every window in the list.
"allow" -- syncs are permitted only while at least one window is active;
           all other times are blocked.
"deny"  -- syncs are blocked while any window is active;
           all other times are permitted.

=cut

=attr windows

Windows is the list of schedule+duration pairs.

=cut

1;
