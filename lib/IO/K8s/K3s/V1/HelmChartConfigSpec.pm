package IO::K8s::K3s::V1::HelmChartConfigSpec;
# ABSTRACT: HelmChartConfigSpec represents additional user-configurable details of an installed and configured Helm chart release.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s failurePolicy  => Str, { enum => [qw(abort reinstall retry)], default => 'reinstall' };
k8s forceConflicts => Bool;
k8s serverSide     => Str, { enum => [qw(true false auto)] };
k8s values         => 'Apiextensions::V1::JSON';
k8s valuesContent  => Str;
k8s valuesSecrets  => ['+IO::K8s::K3s::V1::SecretSpec'];

=attr failurePolicy

Configures handling of failed chart installation or upgrades.
- `abort` will take no action and leave the chart in a failed state so that the administrator can manually resolve the error.
- `reinstall` will perform a clean uninstall and reinstall of the chart; this is the default behavior.
- `retry` will attempt to retry the install or upgrade whenever chart configuration changes.

=cut

=attr forceConflicts

Set to true if helm should configure server-side apply to force changes when conflicts arise in ownership of managed fields.
Helm CLI positional argument/flag: `--force-conflicts`

=cut

=attr serverSide

Set to true if helm should enable server-side apply when updating objects. Defaults to `true` for install, and `auto` for upgrade.
- `true` enables server-side apply.
- `false` disables server-side apply.
- `auto` enables server-side apply if the chart was installed with server-side apply enabled.
Helm CLI positional argument/flag: `--server-side`

=cut

=attr values

Override complex Chart values via structured YAML. Takes precedence over options set via valuesContent.
Helm CLI positional argument/flag: `--values`

=cut

=attr valuesContent

Override complex Chart values via inline YAML content.
Helm CLI positional argument/flag: `--values`

=cut

=attr valuesSecrets

Override complex Chart values via references to external Secrets.
Helm CLI positional argument/flag: `--values`

=cut

1;
