package IO::K8s::Api::Core::V1::PortStatus;
# ABSTRACT: 
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s error => Str;

=attr error

Error is to record the problem with the service port The format of the error shall comply with the following rules: - built-in error values shall be specified in this file and those shall use
  CamelCase names
- cloud provider specific error values must have names that comply with the
  format foo.example.com/CamelCase.

=cut

k8s port => Int, 'required';

=attr port

Port is the port number of the service port of which status is recorded here

=cut

k8s protocol => Str, 'required';

=attr protocol

Protocol is the protocol of the service port of which status is recorded here The supported values are: "TCP", "UDP", "SCTP"

=cut

1;
