package IO::K8s::ExternalSecrets::V1::ExternalSecretSyncWindowEntry;
# ABSTRACT: ExternalSecretSyncWindowEntry defines a single cron-schedule + duration pair within a SyncWindows block.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s duration => Str, { required => 'schema' };
k8s schedule => Str, { required => 'schema', pattern => qr/^(\@(annually|yearly|monthly|weekly|daily|midnight|hourly)|\@every [^\s]+.*|[^\s]+( [^\s]+){4})$/ };

=attr duration

Duration specifies how long the window stays open after each Schedule
firing. Example: "8h".

=cut

=attr schedule

Schedule is a standard 5-field cron expression evaluated in UTC, or a
named shorthand such as @daily or @every 1h. It marks the start time of
each window occurrence.
Example: "0 22 * * 1-5" opens a window every weekday at 22:00 UTC.

=cut

1;
