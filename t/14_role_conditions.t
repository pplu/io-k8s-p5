#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

use IO::K8s;
use IO::K8s::Cilium;

# CiliumNetworkPolicy's status is now a typed CiliumNetworkPolicyStatus (D5,
# task B-Cilium), so every subtest builds through $k8s->new_object -- the
# coercing path (k100: a direct ->new(status => {...}) does not inflate
# nested hashrefs into typed objects) -- and reads a returned condition
# through its accessors rather than as a raw hashref, since it is now a
# blessed Core::V1::NamespaceCondition (reuse_core), not a plain hash.

my $k8s = IO::K8s->new(with => ['IO::K8s::Cilium']);

subtest 'conditions from typed status' => sub {
    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'test-policy' },
        status => {
            conditions => [
                { type => 'Ready',       status => 'True',  message => 'all good' },
                { type => 'Initialized', status => 'True',  message => 'init done' },
                { type => 'Degraded',    status => 'False', message => 'no issues' },
            ],
        },
    );

    my $conds = $cnp->conditions;
    is(scalar @$conds, 3, 'conditions returns all 3');
    isa_ok($conds->[0], 'IO::K8s::Api::Core::V1::NamespaceCondition', 'reused core NamespaceCondition (reuse_core, D5)');

    ok($cnp->is_ready, 'is_ready true when Ready=True');
    ok($cnp->is_condition_true('Initialized'), 'Initialized is True');
    ok(!$cnp->is_condition_true('Degraded'), 'Degraded is False');
    ok(!$cnp->is_condition_true('NonExistent'), 'non-existent condition is false');

    my $cond = $cnp->get_condition('Ready');
    isa_ok($cond, 'IO::K8s::Api::Core::V1::NamespaceCondition', 'get_condition returns the typed object');
    is($cond->status, 'True', 'condition status');

    is($cnp->condition_message('Ready'), 'all good', 'condition_message');
    is($cnp->condition_message('Degraded'), 'no issues', 'condition_message for false');
    is($cnp->condition_message('NonExistent'), undef, 'condition_message for missing');
};

subtest 'is_ready checks Available too' => sub {
    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'test-policy' },
        status => {
            conditions => [
                { type => 'Available',  status => 'True', message => 'deployment available' },
                { type => 'Progressing', status => 'True', message => 'progressing' },
            ],
        },
    );

    ok($cnp->is_ready, 'is_ready true via Available condition');
};

subtest 'is_ready false when neither Ready nor Available' => sub {
    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'test-policy' },
        status => {
            conditions => [
                { type => 'Progressing', status => 'True', message => 'still progressing' },
            ],
        },
    );

    ok(!$cnp->is_ready, 'is_ready false without Ready or Available');
};

subtest 'no status' => sub {
    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'test-policy' },
    );

    my $conds = $cnp->conditions;
    is(scalar @$conds, 0, 'empty conditions when no status');
    ok(!$cnp->is_ready, 'not ready without status');
    is($cnp->get_condition('Ready'), undef, 'get_condition undef without status');
};

subtest 'status without conditions' => sub {
    my $cnp = $k8s->new_object('CiliumNetworkPolicy',
        metadata => { name => 'test-policy' },
        status => { derivativePolicies => {} },
    );

    my $conds = $cnp->conditions;
    is(scalar @$conds, 0, 'empty conditions when status has no conditions');
    ok(!$cnp->is_ready, 'not ready without conditions in status');
};

done_testing;
