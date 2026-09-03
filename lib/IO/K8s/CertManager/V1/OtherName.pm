package IO::K8s::CertManager::V1::OtherName;
# ABSTRACT: OtherName
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s oid       => Str;
k8s utf8Value => Str;

=attr oid

OID is the object identifier for the otherName SAN.
The object identifier must be expressed as a dotted string, for
example, "1.2.840.113556.1.4.221".

=cut

=attr utf8Value

utf8Value is the string value of the otherName SAN.
The utf8Value accepts any valid UTF8 string to set as value for the otherName SAN.

=cut

1;
