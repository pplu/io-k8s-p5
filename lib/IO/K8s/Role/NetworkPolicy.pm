package IO::K8s::Role::NetworkPolicy;
# ABSTRACT: Role for building network policies (core K8s and Cilium)
our $VERSION = '1.108';
use Moo::Role;
use IO::K8s::Types::Net qw( cidr_contains );
use Carp qw(croak);

requires '_netpol_format';

=method select_pods

    $netpol->select_pods(app => 'web', tier => 'frontend');

Sets the policy's podSelector to match pods carrying the given labels. For
core Kubernetes C<NetworkPolicy> this writes C<spec.podSelector.matchLabels>;
for Cilium C<CiliumNetworkPolicy> it writes the
C<spec.endpointSelector.matchLabels> shape. The two formats produce the
same selector semantics; the role picks the right shape based on the
consuming class's C<_netpol_format>. Returns C<$self> for chaining.

=cut

sub select_pods {
    my ($self, %labels) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_ensure_spec;
        $self->spec->podSelector(
            IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector->new(
                matchLabels => \%labels,
            )
        );
    } elsif ($format eq 'cilium') {
        $self->spec_set('endpointSelector', { matchLabels => \%labels });
    }
    return $self;
}

=method allow_ingress_from_pods

    $netpol->allow_ingress_from_pods({ app => 'nginx' }, ports => [{ port => 8080 }]);

Adds an ingress rule allowing traffic from pods matching the given labels.
C<$labels> is a hashref (the C<matchLabels> payload); C<ports> is an
optional arrayref of C<< { port =E<gt> $n, protocol =E<gt> 'TCP' } >>
entries. Core K8s writes C<spec.ingress[].from[].podSelector>; Cilium
writes C<spec.ingress[].fromEndpoints[].matchLabels>. Returns C<$self> for
chaining.

=cut

sub allow_ingress_from_pods {
    my ($self, $labels, %opts) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_add_core_ingress_rule(
            { podSelector => { matchLabels => $labels } },
            $opts{ports},
        );
    } elsif ($format eq 'cilium') {
        $self->_add_cilium_ingress_rule(
            { matchLabels => $labels },
            $opts{ports},
        );
    }
    return $self;
}

=method allow_ingress_from_cidrs

    $netpol->allow_ingress_from_cidrs(['10.0.0.0/8', '192.168.0.0/16'], ports => [...]);

Adds an ingress rule allowing traffic from the given CIDR ranges. Each CIDR
is validated as having a C</> and being parseable by L<Net::IP>; croaks
otherwise. C<ports> is an optional arrayref of C<< { port =E<gt> $n,
protocol =E<gt> 'TCP' } >> entries. Core K8s writes
C<spec.ingress[].from[].ipBlock.cidr>; Cilium writes
C<spec.ingress[].fromCIDR>. Returns C<$self> for chaining.

=cut

sub allow_ingress_from_cidrs {
    my ($self, $cidrs, %opts) = @_;
    _validate_cidrs($cidrs);
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        my @from = map { { ipBlock => { cidr => $_ } } } @$cidrs;
        $self->_add_core_ingress_rule_multi(\@from, $opts{ports});
    } elsif ($format eq 'cilium') {
        $self->spec_push('ingress', {
            fromCIDR => $cidrs,
            $opts{ports} ? (toPorts => [ { ports => $opts{ports} } ]) : (),
        });
    }
    return $self;
}

=method allow_ingress_from_namespace

    $netpol->allow_ingress_from_namespace('kube-system', ports => [...]);

Adds an ingress rule allowing traffic from any pod in the named namespace.
Internally selects on the well-known
C<kubernetes.io/metadata.name =E<gt> $namespace> label (or its Cilium
equivalent C<k8s:io.kubernetes.pod.namespace>). C<ports> is optional.
Returns C<$self> for chaining.

=cut

sub allow_ingress_from_namespace {
    my ($self, $namespace, %opts) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_add_core_ingress_rule(
            { namespaceSelector => { matchLabels => { 'kubernetes.io/metadata.name' => $namespace } } },
            $opts{ports},
        );
    } elsif ($format eq 'cilium') {
        $self->spec_push('ingress', {
            fromEndpoints => [ { matchLabels => { 'k8s:io.kubernetes.pod.namespace' => $namespace } } ],
            $opts{ports} ? (toPorts => [ { ports => $opts{ports} } ]) : (),
        });
    }
    return $self;
}

=method allow_egress_to_pods

    $netpol->allow_egress_to_pods({ app => 'redis' }, ports => [{ port => 6379 }]);

Adds an egress rule allowing traffic to pods matching the given labels.
C<$labels> is a hashref of C<matchLabels>; C<ports> is an optional
arrayref of port spec entries. Core K8s writes C<spec.egress[].to[]>; Cilium
writes C<spec.egress[].toEndpoints[]>. Returns C<$self> for chaining.

=cut

sub allow_egress_to_pods {
    my ($self, $labels, %opts) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_add_core_egress_rule(
            { podSelector => { matchLabels => $labels } },
            $opts{ports},
        );
    } elsif ($format eq 'cilium') {
        $self->spec_push('egress', {
            toEndpoints => [ { matchLabels => $labels } ],
            $opts{ports} ? (toPorts => [ { ports => $opts{ports} } ]) : (),
        });
    }
    return $self;
}

=method allow_egress_to_cidrs

    $netpol->allow_egress_to_cidrs(['0.0.0.0/0']);

Adds an egress rule allowing traffic to the given CIDR ranges (most often
C<['0.0.0.0/0']> for "all external traffic"). Each CIDR is validated as
having a C</> and being parseable by L<Net::IP>; croaks otherwise. Core
K8s writes C<spec.egress[].to[].ipBlock.cidr>; Cilium writes
C<spec.egress[].toCIDR>. Returns C<$self> for chaining.

=cut

sub allow_egress_to_cidrs {
    my ($self, $cidrs) = @_;
    _validate_cidrs($cidrs);
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_add_core_egress_rule_multi(
            [ map { { ipBlock => { cidr => $_ } } } @$cidrs ],
        );
    } elsif ($format eq 'cilium') {
        $self->spec_push('egress', { toCIDR => $cidrs });
    }
    return $self;
}

=method allow_egress_to_dns

    $netpol->allow_egress_to_dns;

Adds an egress rule that allows DNS lookups: TCP and UDP port 53 to the
cluster's CoreDNS pods (C<kube-system/kube-dns>) for core K8s, or the
equivalent Cilium match for Cilium. This is the common "let pods resolve
names" companion to a restrictive egress policy. Returns C<$self> for
chaining.

=cut

sub allow_egress_to_dns {
    my ($self) = @_;
    my $dns_ports = [
        { port => 53, protocol => 'UDP' },
        { port => 53, protocol => 'TCP' },
    ];
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_add_core_egress_rule(undef, $dns_ports);
    } elsif ($format eq 'cilium') {
        $self->spec_push('egress', {
            toEndpoints => [ { matchLabels => { 'k8s:io.kubernetes.pod.namespace' => 'kube-system', 'k8s:k8s-app' => 'kube-dns' } } ],
            toPorts     => [ { ports => $dns_ports } ],
        });
    }
    return $self;
}

=method deny_all_ingress

    $netpol->deny_all_ingress;

Replaces the policy's ingress rules with an empty list, the canonical
"deny all ingress" shape. Core K8s sets C<spec.ingress = []>; Cilium sets
C<spec.ingress = []> and additionally writes a wildcard
C<spec.ingressDeny = [{}]> for consistency with Cilium's deny-first
semantics. Returns C<$self> for chaining.

=cut

sub deny_all_ingress {
    my ($self) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_ensure_spec;
        $self->_ensure_policy_types('Ingress');
        # Empty ingress array = deny all
        $self->spec->ingress([]);
    } elsif ($format eq 'cilium') {
        $self->spec_set('ingress',     []);
        $self->spec_set('ingressDeny', [ {} ]);
    }
    return $self;
}

=method deny_all_egress

    $netpol->deny_all_egress;

Replaces the policy's egress rules with an empty list, the canonical
"deny all egress" shape. Core K8s sets C<spec.egress = []>; Cilium sets
C<spec.egress = []> and additionally writes a wildcard
C<spec.egressDeny = [{}]>. Returns C<$self> for chaining.

=cut

sub deny_all_egress {
    my ($self) = @_;
    my $format = $self->_netpol_format;

    if ($format eq 'core') {
        $self->_ensure_spec;
        $self->_ensure_policy_types('Egress');
        $self->spec->egress([]);
    } elsif ($format eq 'cilium') {
        $self->spec_set('egress',     []);
        $self->spec_set('egressDeny', [ {} ]);
    }
    return $self;
}

# --- Private helpers ---

sub _validate_cidrs {
    my ($cidrs) = @_;
    require IO::K8s::Types::Net;
    for my $cidr (@$cidrs) {
        croak "'$cidr' is not valid CIDR notation"
            unless $cidr =~ /\// && defined Net::IP->new($cidr);
    }
}

# Core K8s helpers (work on typed spec objects)
sub _ensure_spec {
    my ($self) = @_;
    unless ($self->spec) {
        if ($self->_netpol_format eq 'core') {
            require IO::K8s::Api::Networking::V1::NetworkPolicySpec;
            $self->spec(IO::K8s::Api::Networking::V1::NetworkPolicySpec->new(
                podSelector => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector->new,
            ));
        }
    }
}

sub _ensure_policy_types {
    my ($self, $type) = @_;
    return unless $self->_netpol_format eq 'core';
    my $spec = $self->spec;
    my $types = $spec->policyTypes // [];
    unless (grep { $_ eq $type } @$types) {
        push @$types, $type;
        $spec->policyTypes($types);
    }
}

sub _core_ports {
    my ($ports) = @_;
    return () unless $ports;
    return (ports => [
        map {
            IO::K8s::Api::Networking::V1::NetworkPolicyPort->new(
                port     => $_->{port},
                protocol => $_->{protocol} // 'TCP',
            )
        } @$ports
    ]);
}

sub _add_core_ingress_rule {
    my ($self, $from, $ports) = @_;
    $self->_ensure_spec;
    $self->_ensure_policy_types('Ingress');
    my $spec = $self->spec;
    my $ingress = $spec->ingress // [];

    my %rule;
    $rule{from} = [
        IO::K8s::Api::Networking::V1::NetworkPolicyPeer->new(%$from)
    ] if $from;
    if ($ports) {
        $rule{ports} = [
            map {
                IO::K8s::Api::Networking::V1::NetworkPolicyPort->new(
                    port => $_->{port}, protocol => $_->{protocol} // 'TCP',
                )
            } @$ports
        ];
    }

    push @$ingress, IO::K8s::Api::Networking::V1::NetworkPolicyIngressRule->new(%rule);
    $spec->ingress($ingress);
}

sub _add_core_ingress_rule_multi {
    my ($self, $from_list, $ports) = @_;
    $self->_ensure_spec;
    $self->_ensure_policy_types('Ingress');
    my $spec = $self->spec;
    my $ingress = $spec->ingress // [];

    my %rule;
    $rule{from} = [
        map { IO::K8s::Api::Networking::V1::NetworkPolicyPeer->new(%$_) } @$from_list
    ] if $from_list;
    if ($ports) {
        $rule{ports} = [
            map {
                IO::K8s::Api::Networking::V1::NetworkPolicyPort->new(
                    port => $_->{port}, protocol => $_->{protocol} // 'TCP',
                )
            } @$ports
        ];
    }

    push @$ingress, IO::K8s::Api::Networking::V1::NetworkPolicyIngressRule->new(%rule);
    $spec->ingress($ingress);
}

sub _add_core_egress_rule {
    my ($self, $to, $ports) = @_;
    $self->_ensure_spec;
    $self->_ensure_policy_types('Egress');
    my $spec = $self->spec;
    my $egress = $spec->egress // [];

    my %rule;
    $rule{to} = [
        IO::K8s::Api::Networking::V1::NetworkPolicyPeer->new(%$to)
    ] if $to;
    if ($ports) {
        $rule{ports} = [
            map {
                IO::K8s::Api::Networking::V1::NetworkPolicyPort->new(
                    port => $_->{port}, protocol => $_->{protocol} // 'TCP',
                )
            } @$ports
        ];
    }

    push @$egress, IO::K8s::Api::Networking::V1::NetworkPolicyEgressRule->new(%rule);
    $spec->egress($egress);
}

sub _add_core_egress_rule_multi {
    my ($self, $to_list, $ports) = @_;
    $self->_ensure_spec;
    $self->_ensure_policy_types('Egress');
    my $spec = $self->spec;
    my $egress = $spec->egress // [];

    my %rule;
    $rule{to} = [
        map { IO::K8s::Api::Networking::V1::NetworkPolicyPeer->new(%$_) } @$to_list
    ] if $to_list;
    if ($ports) {
        $rule{ports} = [
            map {
                IO::K8s::Api::Networking::V1::NetworkPolicyPort->new(
                    port => $_->{port}, protocol => $_->{protocol} // 'TCP',
                )
            } @$ports
        ];
    }

    push @$egress, IO::K8s::Api::Networking::V1::NetworkPolicyEgressRule->new(%rule);
    $spec->egress($egress);
}

sub _add_cilium_ingress_rule {
    my ($self, $endpoint_selector, $ports) = @_;
    $self->spec_push('ingress', {
        fromEndpoints => [ $endpoint_selector ],
        $ports ? (toPorts => [ { ports => $ports } ]) : (),
    });
}

1;

__END__

=head1 SYNOPSIS

    package My::NetPol;
    use IO::K8s::APIObject api_version => 'networking.k8s.io/v1';
    with 'IO::K8s::Role::NetworkPolicy';

    sub _netpol_format { 'core' }   # or 'cilium'

    package main;
    my $p = My::NetPol->new;
    $p->select_pods(app => 'web')
      ->allow_ingress_from_pods({ app => 'nginx' }, ports => [{ port => 8080 }])
      ->allow_egress_to_dns
      ->deny_all_egress;

=head1 DESCRIPTION

This role provides the fluent network-policy builders documented in the
README's "Network policies" section. The same chain works against both
core Kubernetes C<NetworkPolicy> and Cilium C<CiliumNetworkPolicy> CRDs;
the role dispatches on a C<_netpol_format> method the consumer must
implement, returning either C<'core'> or C<'cilium'>.

Core K8s operations build typed L<IO::K8s::Api::Networking::V1::NetworkPolicySpec>
objects (with the canonical C<from>/C<to>/C<ports> shape and the
C<policyTypes> field maintained automatically); Cilium operations write
plain hashrefs (C<fromEndpoints>/C<toEndpoints>/C<fromCIDR>/C<toCIDR>).
The two paths live in the same role because most consumers either commit
fully to core K8s or fully to Cilium and do not switch mid-flow.

CIDR-accepting methods (C<allow_ingress_from_cidrs>, C<allow_egress_to_cidrs>)
validate each input through L<IO::K8s::Types::Net/IPAddress> semantics and
croak on a malformed value rather than letting the cluster reject the
manifest after the fact.

=head1 REQUIRED METHODS

=head2 _netpol_format

Must return C<'core'> or C<'cilium'>. The role dispatches all method bodies
on this answer; a missing or unknown value is treated as a no-op.

=head1 SEE ALSO

L<IO::K8s::Cilium>, L<IO::K8s::Types::Net>,
L<IO::K8s::Api::Networking::V1::NetworkPolicySpec>, L<IO::K8s::APIObject>

=cut