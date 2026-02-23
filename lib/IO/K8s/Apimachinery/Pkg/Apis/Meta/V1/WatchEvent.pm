package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::WatchEvent;
# ABSTRACT: Event represents a single event to a watched resource.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s object => { Str => 1 };

=attr object

Object is: * If Type is Added or Modified: the new state of the object. * If Type is Deleted: the state of the object immediately before deletion. * If Type is Error: *Status is recommended; other types may make sense depending on context.

=cut

k8s type => Str, 'required';

1;
