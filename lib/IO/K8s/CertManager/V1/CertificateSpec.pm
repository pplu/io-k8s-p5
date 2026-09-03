package IO::K8s::CertManager::V1::CertificateSpec;
# ABSTRACT: Specification of the desired state of the Certificate resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s additionalOutputFormats => ['+IO::K8s::CertManager::V1::CertificateAdditionalOutputFormat'];
k8s commonName              => Str;
k8s dnsNames                => [Str];
k8s duration                => Str;
k8s emailAddresses          => [Str];
k8s encodeUsagesInRequest   => Bool;
k8s ipAddresses             => [Str];
k8s isCA                    => Bool;
k8s issuerRef               => '+IO::K8s::CertManager::V1::IssuerReference', { required => 'schema' };
k8s keystores               => '+IO::K8s::CertManager::V1::CertificateKeystores';
k8s literalSubject          => Str;
k8s nameConstraints         => '+IO::K8s::CertManager::V1::NameConstraints';
k8s otherNames              => ['+IO::K8s::CertManager::V1::OtherName'];
k8s privateKey              => '+IO::K8s::CertManager::V1::CertificatePrivateKey';
k8s renewBefore             => Str;
k8s renewBeforePercentage   => Int;
k8s renewal                 => '+IO::K8s::CertManager::V1::CertificateRenewal';
k8s revisionHistoryLimit    => Int;
k8s secretName              => Str, { required => 'schema' };
k8s secretTemplate          => '+IO::K8s::CertManager::V1::CertificateSecretTemplate';
k8s signatureAlgorithm      => Str, { enum => [qw(SHA256WithRSA SHA384WithRSA SHA512WithRSA ECDSAWithSHA256 ECDSAWithSHA384 ECDSAWithSHA512 PureEd25519)] };
k8s subject                 => '+IO::K8s::CertManager::V1::X509Subject';
k8s uris                    => [Str];
k8s usages                  => [Str], { enum => ['signing','digital signature','content commitment','key encipherment','key agreement','data encipherment','cert sign','crl sign','encipher only','decipher only','any','server auth','client auth','code signing','email protection','s/mime','ipsec end system','ipsec tunnel','ipsec user','timestamping','ocsp signing','microsoft sgc','netscape sgc'] };

=attr additionalOutputFormats

Defines extra output formats of the private key and signed certificate chain
to be written to this Certificate's target Secret.

=cut

=attr commonName

Requested common name X509 certificate subject attribute.
More info: https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6
NOTE: TLS clients will ignore this value when any subject alternative name is
set (see https://tools.ietf.org/html/rfc6125#section-6.4.4).

Should have a length of 64 characters or fewer to avoid generating invalid CSRs.
Cannot be set if the `literalSubject` field is set.

=cut

=attr dnsNames

Requested DNS subject alternative names.

=cut

=attr duration

Requested 'duration' (i.e. lifetime) of the Certificate. Note that the
issuer may choose to ignore the requested duration, just like any other
requested attribute.

If unset, this defaults to 90 days.
Minimum accepted duration is 1 hour.
Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration.

=cut

=attr emailAddresses

Requested email subject alternative names.

=cut

=attr encodeUsagesInRequest

Whether the KeyUsage and ExtKeyUsage extensions should be set in the encoded CSR.

This option defaults to true, and should only be disabled if the target
issuer does not support CSRs with these X509 KeyUsage/ ExtKeyUsage extensions.

=cut

=attr ipAddresses

Requested IP address subject alternative names.

=cut

=attr isCA

Requested basic constraints isCA value.
The isCA value is used to set the `isCA` field on the created CertificateRequest
resources. Note that the issuer may choose to ignore the requested isCA value, just
like any other requested attribute.

If true, this will automatically add the `cert sign` usage to the list
of requested `usages`.

=cut

=attr issuerRef

Reference to the issuer responsible for issuing the certificate.
If the issuer is namespace-scoped, it must be in the same namespace
as the Certificate. If the issuer is cluster-scoped, it can be used
from any namespace.

The `name` field of the reference must always be specified.

=cut

=attr keystores

Additional keystore output formats to be stored in the Certificate's Secret.

=cut

=attr literalSubject

Requested X.509 certificate subject, represented using the LDAP "String
Representation of a Distinguished Name" [1].
Important: the LDAP string format also specifies the order of the attributes
in the subject, this is important when issuing certs for LDAP authentication.
Example: `CN=foo,DC=corp,DC=example,DC=com`
More info [1]: https://datatracker.ietf.org/doc/html/rfc4514
More info: https://github.com/cert-manager/cert-manager/issues/3203
More info: https://github.com/cert-manager/cert-manager/issues/4424

Cannot be set if the `subject` or `commonName` field is set.

=cut

=attr nameConstraints

x.509 certificate NameConstraint extension which MUST NOT be used in a non-CA certificate.
More Info: https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.10

This is an Alpha Feature and is only enabled with the
`--feature-gates=NameConstraints=true` option set on both
the controller and webhook components.

=cut

=attr otherNames

`otherNames` is an escape hatch for SAN that allows any type. We currently restrict the support to string like otherNames, cf RFC 5280 p 37
Any UTF8 String valued otherName can be passed with by setting the keys oid: x.x.x.x and UTF8Value: somevalue for `otherName`.
Most commonly this would be UPN set with oid: 1.3.6.1.4.1.311.20.2.3
You should ensure that any OID passed is valid for the UTF8String type as we do not explicitly validate this.

=cut

=attr privateKey

Private key options. These include the key algorithm and size, the used
encoding and the rotation policy.

=cut

=attr renewBefore

How long before the currently issued certificate's expiry cert-manager should
renew the certificate. For example, if a certificate is valid for 60 minutes,
and `renewBefore=10m`, cert-manager will begin to attempt to renew the certificate
50 minutes after it was issued (i.e. when there are 10 minutes remaining until
the certificate is no longer valid).

NOTE: The actual lifetime of the issued certificate is used to determine the
renewal time. If an issuer returns a certificate with a different lifetime than
the one requested, cert-manager will use the lifetime of the issued certificate.

If unset, this defaults to 1/3 of the issued certificate's lifetime.
Minimum accepted value is 5 minutes.
Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration.
Cannot be set if the `renewBeforePercentage` field is set.

=cut

=attr renewBeforePercentage

`renewBeforePercentage` is like `renewBefore`, except it is a relative percentage
rather than an absolute duration. For example, if a certificate is valid for 60
minutes, and  `renewBeforePercentage=25`, cert-manager will begin to attempt to
renew the certificate 45 minutes after it was issued (i.e. when there are 15
minutes (25%) remaining until the certificate is no longer valid).

NOTE: The actual lifetime of the issued certificate is used to determine the
renewal time. If an issuer returns a certificate with a different lifetime than
the one requested, cert-manager will use the lifetime of the issued certificate.

Value must be an integer in the range (0,100). The minimum effective
`renewBefore` derived from the `renewBeforePercentage` and `duration` fields is 5
minutes.
Cannot be set if the `renewBefore` field is set.

=cut

=attr renewal

`renewal` allows configuration of how your certificate is renewed. If the policy mentioned is
`RenewBefore` then the controller respects `renewBefore` and `renewBeforePercentage`.

=cut

=attr revisionHistoryLimit

The maximum number of CertificateRequest revisions that are maintained in
the Certificate's history. Each revision represents a single `CertificateRequest`
created by this Certificate, either when it was created, renewed, or Spec
was changed. Revisions will be removed by oldest first if the number of
revisions exceeds this number.

If set, revisionHistoryLimit must be a value of `1` or greater.
Default value is `1`.

=cut

=attr secretName

Name of the Secret resource that will be automatically created and
managed by this Certificate resource. It will be populated with a
private key and certificate, signed by the denoted issuer. The Secret
resource lives in the same namespace as the Certificate resource.

=cut

=attr secretTemplate

Defines annotations and labels to be copied to the Certificate's Secret.
Labels and annotations on the Secret will be changed as they appear on the
SecretTemplate when added or removed. SecretTemplate annotations are added
in conjunction with, and cannot overwrite, the base set of annotations
cert-manager sets on the Certificate's Secret.

=cut

=attr signatureAlgorithm

Signature algorithm to use.
Allowed values for RSA keys: SHA256WithRSA, SHA384WithRSA, SHA512WithRSA.
Allowed values for ECDSA keys: ECDSAWithSHA256, ECDSAWithSHA384, ECDSAWithSHA512.
Allowed values for Ed25519 keys: PureEd25519.

=cut

=attr subject

Requested set of X509 certificate subject attributes.
More info: https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6

The common name attribute is specified separately in the `commonName` field.
Cannot be set if the `literalSubject` field is set.

=cut

=attr uris

Requested URI subject alternative names.

=cut

=attr usages

Requested key usages and extended key usages.
These usages are used to set the `usages` field on the created CertificateRequest
resources. If `encodeUsagesInRequest` is unset or set to `true`, the usages
will additionally be encoded in the `request` field which contains the CSR blob.

If unset, defaults to `digital signature` and `key encipherment`.

=cut

1;
