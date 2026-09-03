#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

use IO::K8s::Cilium::V2::CiliumNetworkPolicy;
use IO::K8s::Cilium::V2::CiliumClusterwideNetworkPolicy;
use IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta;

# --- Cilium NetworkPolicy ---
# spec is a typed IO::K8s::Cilium::V2::Rule object as of task B-Cilium (D5)
# -- never passed as a raw hashref to ->new (k100: a direct ->new(spec =>
# {...}) does not coerce) and never read back via ->spec->{key} (fragile
# hash-key access on a blessed object). Every method under test writes
# through spec_set/spec_push (IO::K8s::Role::SpecBuilder, which the role's
# own method bodies already use and which auto-vivifies a typed spec, k90);
# assertions below read the typed accessors or TO_JSON.

subtest 'cilium: select_pods' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->select_pods(app => 'web', tier => 'frontend');
    isa_ok($cnp->spec, 'IO::K8s::Cilium::V2::Rule');
    isa_ok($cnp->spec->endpointSelector, 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector');
    is_deeply($cnp->spec->endpointSelector->matchLabels, { app => 'web', tier => 'frontend' }, 'select_pods sets endpointSelector');
};

subtest 'cilium: allow_ingress_from_pods' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_ingress_from_pods({ app => 'nginx' }, ports => [{ port => 8080, protocol => 'TCP' }]);
    my $ingress = $cnp->spec->ingress;
    is(scalar @$ingress, 1, 'one ingress rule');
    isa_ok($ingress->[0], 'IO::K8s::Cilium::V2::IngressRule');
    is_deeply($ingress->[0]->TO_JSON->{fromEndpoints}, [{ matchLabels => { app => 'nginx' } }], 'from endpoints');
    is($ingress->[0]->TO_JSON->{toPorts}[0]{ports}[0]{port}, 8080, 'port');
};

subtest 'cilium: allow_ingress_from_cidrs' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_ingress_from_cidrs(['192.168.0.0/16', '10.0.0.0/8']);
    my $ingress = $cnp->spec->ingress;
    is_deeply($ingress->[0]->TO_JSON->{fromCIDR}, ['192.168.0.0/16', '10.0.0.0/8'], 'fromCIDR');
};

subtest 'cilium: allow_ingress_from_namespace' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_ingress_from_namespace('monitoring', ports => [{ port => 9090 }]);
    my $ingress = $cnp->spec->ingress;
    ok($ingress->[0]->TO_JSON->{fromEndpoints}[0]{matchLabels}{'k8s:io.kubernetes.pod.namespace'}, 'namespace set');
};

subtest 'cilium: allow_egress_to_pods' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_egress_to_pods({ app => 'db' }, ports => [{ port => 5432 }]);
    my $egress = $cnp->spec->egress;
    is_deeply($egress->[0]->TO_JSON->{toEndpoints}, [{ matchLabels => { app => 'db' } }], 'to endpoints');
};

subtest 'cilium: allow_egress_to_cidrs' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_egress_to_cidrs(['10.0.0.0/8']);
    is_deeply($cnp->spec->egress->[0]->TO_JSON->{toCIDR}, ['10.0.0.0/8'], 'toCIDR');
};

subtest 'cilium: allow_egress_to_dns' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->allow_egress_to_dns;
    my $egress = $cnp->spec->egress;
    ok($egress->[0]->TO_JSON->{toPorts}, 'dns ports set');
    is(scalar @{$egress->[0]->TO_JSON->{toPorts}[0]{ports}}, 2, 'UDP and TCP');
};

subtest 'cilium: deny_all_ingress' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->deny_all_ingress;
    is_deeply($cnp->spec->ingress, [], 'empty ingress');
    ok($cnp->spec->ingressDeny, 'ingressDeny set');
};

subtest 'cilium: deny_all_egress' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    $cnp->deny_all_egress;
    is_deeply($cnp->spec->egress, [], 'empty egress');
    ok($cnp->spec->egressDeny, 'egressDeny set');
};

subtest 'cilium: CIDR validation' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    dies_ok { $cnp->allow_ingress_from_cidrs(['not-a-cidr']) } 'rejects bad CIDR';
    dies_ok { $cnp->allow_egress_to_cidrs(['garbage']) } 'rejects bad egress CIDR';
};

subtest 'cilium: chaining' => sub {
    my $cnp = IO::K8s::Cilium::V2::CiliumNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-policy', namespace => 'default',
        ),
    );

    my $result = $cnp->select_pods(app => 'web')
                     ->allow_ingress_from_pods({ app => 'nginx' })
                     ->allow_egress_to_dns;

    is($result, $cnp, 'chaining returns self');
    ok($cnp->spec->endpointSelector, 'endpointSelector set via chain');
    ok($cnp->spec->ingress, 'ingress set via chain');
    ok($cnp->spec->egress, 'egress set via chain');
};

# --- CiliumClusterwideNetworkPolicy ---

subtest 'clusterwide network policy' => sub {
    my $ccnp = IO::K8s::Cilium::V2::CiliumClusterwideNetworkPolicy->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'global-deny',
        ),
    );

    $ccnp->select_pods(app => 'web')->deny_all_ingress;
    isa_ok($ccnp->spec, 'IO::K8s::Cilium::V2::Rule');
    ok($ccnp->spec->endpointSelector, 'clusterwide endpoint selector');
    ok($ccnp->spec->ingressDeny, 'clusterwide deny');
};

done_testing;
