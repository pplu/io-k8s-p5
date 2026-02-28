package IO::K8s::Api::Networking::V1::IngressPortStatus;
# ABSTRACT: IngressPortStatus represents the error condition of a service port
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s error => Str;

=attr error

error is to record the problem with the service port The format of the error shall comply with the following rules: - built-in error values shall be specified in this file and those shall use CamelCase names - cloud provider specific error values must have names that comply with the format foo.example.com/CamelCase.

=cut

k8s port => Int, 'required';

=attr port

port is the port number of the ingress port.

=cut

k8s protocol => Str, 'required';

=attr protocol

protocol is the protocol of the ingress port. The supported values are: "TCP", "UDP", "SCTP"

=cut

1;
