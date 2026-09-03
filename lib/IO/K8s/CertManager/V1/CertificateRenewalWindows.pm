package IO::K8s::CertManager::V1::CertificateRenewalWindows;
# ABSTRACT: CertificateRenewalWindows is the definition for renewal windows
our $VERSION = '1.108';
use utf8;
use IO::K8s::Resource;

k8s cron           => Str, { required => 'schema' };
k8s timezone       => Str;
k8s windowDuration => Str, { required => 'schema', pattern => qr/^([0-9]+(\.[0-9]+)?(s|m|h))+$/ };

=encoding UTF-8

=cut

=attr cron

`cron` is a cron compliant string to allow when the renewal should be allowed. Format is as shown below:
* * * * *
| | | | |
| | | | day of the week (0–6) (Sunday to Saturday;
| | | month (1–12)             7 is also Sunday on some systems)
| | day of the month (1–31)
| hour (0–23)
minute (0–59)

=cut

=attr timezone

`timezone` is IANA compliant timezone. For example America/Denver.
If this field is not set, timezone is treated as UTC.

=cut

=attr windowDuration

`windowDuration` is how long the cron definition is active for.
Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration.

=cut

1;
