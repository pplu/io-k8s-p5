package IO::K8s::GatewayAPI::V1beta1::HTTPHeaderFilter;
# ABSTRACT: ResponseHeaderModifier defines a schema for a filter that modifies response headers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s add    => ['Core::V1::HTTPHeader'];
k8s remove => [Str];
k8s set    => ['Core::V1::HTTPHeader'];

=attr add

Add adds the given header(s) (name, value) to the request
before the action. It appends to any existing values associated
with the header name.

Input:
  GET /foo HTTP/1.1
  my-header: foo

Config:
  add:
  - name: "my-header"
    value: "bar,baz"

Output:
  GET /foo HTTP/1.1
  my-header: foo,bar,baz

=cut

=attr remove

Remove the given header(s) from the HTTP request before the action. The
value of Remove is a list of HTTP header names. Note that the header
names are case-insensitive (see
https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).

Input:
  GET /foo HTTP/1.1
  my-header1: foo
  my-header2: bar
  my-header3: baz

Config:
  remove: ["my-header1", "my-header3"]

Output:
  GET /foo HTTP/1.1
  my-header2: bar

=cut

=attr set

Set overwrites the request with the given header (name, value)
before the action.

Input:
  GET /foo HTTP/1.1
  my-header: foo

Config:
  set:
  - name: "my-header"
    value: "bar"

Output:
  GET /foo HTTP/1.1
  my-header: bar

=cut

1;
