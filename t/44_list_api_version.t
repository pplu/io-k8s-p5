#!/usr/bin/env perl
# Regression coverage for karr ticket #22:
#
# IO::K8s::List::api_version() used to derive the wire apiVersion for
# empty lists from item_class with a local regex that lc()-ed the
# CamelCase group component of the class name. That produces shortened,
# invalid wire versions for every group whose upstream name carries a
# ".k8s.io" suffix:
#
#   - item_class => 'IO::K8s::Api::Rbac::V1::Role'      used to compute
#     "rbac/v1", upstream is "rbac.authorization.k8s.io/v1"
#   - item_class => 'IO::K8s::Api::Storage::V1::StorageClass' used to
#     compute "storage/v1", upstream is "storage.k8s.io/v1"
#   - item_class => 'IO::K8s::Api::Events::V1::Event'   used to compute
#     "events/v1", upstream is "events.k8s.io/v1"
#
# Core ("IO::K8s::Api::Core::V1::*" -> "v1") and groups whose CamelCase
# lc-form already matches the upstream group (apps, batch, autoscaling,
# policy) were correct and must stay correct. Because TO_JSON always calls
# $self->api_version, an empty list with such an item_class serialised a
# syntactically plausible but wrong apiVersion that a real Kubernetes API
# server would reject.
#
# The fix derives the wire version from the item_class's own
# api_version class method (IO::K8s::Role::APIObject::api_version, which
# consults %API_GROUP_MAP) and returns undef for unloadable or
# non-API classes, instead of running the local regex.

use strict;
use warnings;
use Test::More;
use JSON::MaybeXS;

use IO::K8s::List;
use IO::K8s::Api::Core::V1::Pod;

my $json = JSON::MaybeXS->new(utf8 => 0, canonical => 1, allow_nonref => 1);

# Empty lists with a valid API item_class must yield the item class's
# own wire apiVersion (the exact string a real server would expect).
my %EXPECTED = (
    'IO::K8s::Api::Core::V1::Pod'                       => 'v1',
    'IO::K8s::Api::Apps::V1::Deployment'                => 'apps/v1',
    'IO::K8s::Api::Rbac::V1::Role'                      => 'rbac.authorization.k8s.io/v1',
    'IO::K8s::Api::Storage::V1::StorageClass'           => 'storage.k8s.io/v1',
    'IO::K8s::Api::Events::V1::Event'                   => 'events.k8s.io/v1',
    'IO::K8s::Api::Networking::V1::NetworkPolicy'       => 'networking.k8s.io/v1',
    'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinition'
        => 'apiextensions.k8s.io/v1',
    'IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::V1::APIService'
        => 'apiregistration.k8s.io/v1',
);

for my $class (sort keys %EXPECTED) {
    my $list = IO::K8s::List->new( items => [], item_class => $class );
    is( $list->api_version, $EXPECTED{$class},
        "empty list with item_class $class derives api_version '$EXPECTED{$class}'" );

    my $wire = $json->decode($list->to_json);
    is( $wire->{apiVersion}, $EXPECTED{$class},
        "empty list with item_class $class serialises apiVersion '$EXPECTED{$class}'" );
    is( $wire->{kind}, $class =~ /::(\w+)$/ ? "$1List" : undef,
        "empty list with item_class $class serialises a kind" );
}

# An unloadable / non-API item_class must yield undef, not crash and not
# emit a bogus apiVersion in the serialised form.
for my $class (
    'IO::K8s::SomeBogusClass',       # does not exist at all
    'IO::K8s::Api::Rbac::V1::NoSuchKind',  # class name without a file
    'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ListMeta',  # loads, no api_version
    'IO::K8s::List',  # loads, api_version is instance-only: class call must not crash
) {
    my $list = IO::K8s::List->new( items => [], item_class => $class );
    is( $list->api_version, undef,
        "empty list with item_class $class derives api_version undef" );

    my $wire = $json->decode($list->to_json);
    ok( !exists $wire->{apiVersion},
        "empty list with item_class $class serialises without apiVersion" );
}

# kind() must still derive from item_class for empty lists (regression).
{
    my $list = IO::K8s::List->new(
        items      => [],
        item_class => 'IO::K8s::Api::Rbac::V1::Role',
    );
    is( $list->kind, 'RoleList', 'kind() still derives RoleList from item_class' );
}

# Non-empty lists must keep deriving from the first item.
{
    my $pod = IO::K8s::List->new(
        items => [ IO::K8s::Api::Core::V1::Pod->new ],
    );
    is( $pod->api_version, 'v1', 'api_version still derived from first item' );
    is( $pod->kind, 'PodList', 'kind still derived from first item' );
}

# ---------------------------------------------------------------------------
# karr #41: the item_class fallback in kind() derived the Kind from the last
# '::' segment and returned undef when the name had none, so an empty list of
# a single-segment CRD Kind serialised apiVersion but no kind: at all -- a
# manifest the API server rejects. That empty list is precisely what
# item_class exists for ("Used for empty lists where the type can't be
# inferred"), so the fallback failed in its only case. Same defect as karr
# #38, which fixed the equivalent derivation in IO::K8s::Role::APIObject and
# thereby the first-item path here.
# ---------------------------------------------------------------------------

{
    package Bauble;
    BEGIN { $INC{'Bauble.pm'} = __FILE__ }
    use IO::K8s::APIObject
        api_version     => 'vendor.example.com/v1',
        resource_plural => 'baubles';
    k8s spec => { Str => 1 };
}

# The fix: an EMPTY list with a single-segment item_class. There is no first
# item to ask, so kind() must fall back to item_class -- with no '::' the
# whole name is the last segment.
{
    my $list = IO::K8s::List->new( items => [], item_class => 'Bauble' );
    is( $list->kind, 'BaubleList',
        'empty list with single-segment item_class derives kind BaubleList' );
    is( $list->api_version, 'vendor.example.com/v1',
        'and still derives the item class api_version' );

    my $wire = $json->decode($list->to_json);
    is( $wire->{kind}, 'BaubleList',
        'empty list with single-segment item_class serialises kind: -- the field whose absence the API server rejects' );
    is( $wire->{apiVersion}, 'vendor.example.com/v1',
        'alongside its apiVersion' );
    is_deeply( $wire->{items}, [], 'and an empty items array' );
}

# The control: a NON-empty list of the same single-segment class goes through
# the first-item path, which karr #38 already fixed. Asserted here so a later
# rework of either path cannot silently drop the kind again.
{
    my $list = IO::K8s::List->new(
        items => [ Bauble->new( spec => { size => 'l' } ) ],
    );
    is( $list->kind, 'BaubleList',
        'non-empty list of a single-segment class derives kind from the first item' );

    my $wire = $json->decode($list->to_json);
    is( $wire->{kind}, 'BaubleList',
        'non-empty list of a single-segment class serialises kind:' );
    is( $wire->{apiVersion}, 'vendor.example.com/v1',
        'and the first item api_version' );
    is( $wire->{items}[0]{kind}, 'Bauble',
        'the item itself carries its own kind (karr #38)' );
}

done_testing;
