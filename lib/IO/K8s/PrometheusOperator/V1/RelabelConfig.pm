package IO::K8s::PrometheusOperator::V1::RelabelConfig;
# ABSTRACT: RelabelConfig allows dynamic rewriting of the label set for targets, alerts, scraped samples and remote write samples.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s action       => Str, { enum => [qw(replace Replace keep Keep drop Drop hashmod HashMod labelmap LabelMap labeldrop LabelDrop labelkeep LabelKeep lowercase Lowercase uppercase Uppercase keepequal KeepEqual dropequal DropEqual)], default => 'replace' };
k8s modulus      => Int, { minimum => 0 };
k8s regex        => Str;
k8s replacement  => Str;
k8s separator    => Str;
k8s sourceLabels => [Str];
k8s targetLabel  => Str;

=attr action

action to perform based on the regex matching.

`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.

Default: "Replace"

=cut

=attr modulus

modulus to take of the hash of the source label values.

Only applicable when the action is `HashMod`.

=cut

=attr regex

regex defines the regular expression against which the extracted value is matched.

=cut

=attr replacement

replacement value against which a Replace action is performed if the
regular expression matches.

Regex capture groups are available.

=cut

=attr separator

separator defines the string between concatenated SourceLabels.

=cut

=attr sourceLabels

sourceLabels defines the source labels select values from existing labels. Their content is
concatenated using the configured Separator and matched against the
configured regular expression.

=cut

=attr targetLabel

targetLabel defines the label to which the resulting string is written in a replacement.

It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
`KeepEqual` and `DropEqual` actions.

Regex capture groups are available.

=cut

1;
