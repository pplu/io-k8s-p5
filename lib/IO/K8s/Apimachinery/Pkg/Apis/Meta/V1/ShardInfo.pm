package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ShardInfo;
# ABSTRACT: ShardInfo describes the shard selector that was applied to produce a list response. Its presence on a list response indicates the list is a filtered subset.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s selector => Str, 'required';

=attr selector

selector is the shard selector string from the request, echoed back so clients can verify which shard they received and merge responses from multiple shards.

=cut

1;
