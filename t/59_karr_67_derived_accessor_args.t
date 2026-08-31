#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;
use IO::K8s::Api::Core::V1::Pod;
use IO::K8s::Api::Apps::V1::Deployment;

# karr #67: kind() and api_version() are derived, read-only methods. They used
# to accept and silently ignore an argument, so a caller who believed they had
# retargeted an object got no error and the write vanished. The fail-closed
# house line (karr #37/#39/#42) is to croak.

my $pod = IO::K8s::Api::Core::V1::Pod->new;

# The no-argument reads are unchanged.
is($pod->kind, 'Pod', 'kind() reads the derived Kind');
is($pod->api_version, 'v1', 'api_version() reads the derived apiVersion');

# Passing an argument now dies instead of swallowing it.
throws_ok { $pod->kind('Other') }
    qr/kind is derived from the class name and cannot be set/,
    'kind($arg) croaks instead of silently ignoring the argument';
throws_ok { $pod->api_version('v9') }
    qr/api_version is derived from the class name and cannot be set/,
    'api_version($arg) croaks instead of silently ignoring the argument';

# The object is unchanged after a rejected write attempt.
is($pod->kind, 'Pod', 'kind unchanged after the rejected write');
is($pod->api_version, 'v1', 'api_version unchanged after the rejected write');

# Works the same as a class method and on another Kind.
throws_ok { IO::K8s::Api::Apps::V1::Deployment->kind('X') }
    qr/kind is derived from the class name and cannot be set/,
    'kind($arg) croaks as a class method too';
is(IO::K8s::Api::Apps::V1::Deployment->api_version, 'apps/v1',
   'api_version() still derives the group/version with no argument');

# CRD classes declare api_version as an import parameter, installed as a fixed
# identity method. It must reject a write the same way.
{
    package Test::Karr67::StaticWebSite;
    use IO::K8s::APIObject
        api_version     => 'homelab.example.com/v1',
        resource_plural => 'staticwebsites';
}

my $crd = Test::Karr67::StaticWebSite->new;
is($crd->api_version, 'homelab.example.com/v1', 'CRD api_version reads its declared identity');
is($crd->kind, 'StaticWebSite', 'CRD kind derives from the package name');
throws_ok { $crd->api_version('other/v9') }
    qr/api_version is fixed for this class and cannot be set/,
    'CRD api_version($arg) croaks -- the declared identity is read-only';
throws_ok { $crd->kind('Other') }
    qr/kind is derived from the class name and cannot be set/,
    'CRD kind($arg) croaks via the role';

done_testing;
