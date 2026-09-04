#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;
use File::Temp;
use JSON::MaybeXS;

use IO::K8s::Traefik::V1alpha1::IngressRoute;
use IO::K8s::GatewayAPI::V1::HTTPRoute;
use IO::K8s::GatewayAPI::V1::GRPCRoute;
use IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta;
use IO::K8s::Api::Networking::V1::Ingress;

# --- Traefik IngressRoute ---

# Traefik's IngressRouteSpec is a full-depth typed class (k95/D5) as of
# this suite: 'spec' is an IngressRouteSpec/Route object graph, not an
# opaque hashref, so these subtests seed via spec_push (which coerces,
# same as add_hostname/add_backend/... themselves do through
# IO::K8s::Role::SpecBuilder) rather than a raw ->new(spec => {...}) --
# direct ->new does not coerce a hashref into a named nested class (k100).

subtest 'traefik: add_hostname' => sub {
    my $ir = IO::K8s::Traefik::V1alpha1::IngressRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    $ir->add_hostname('example.com', 'www.example.com');
    my $routes = $ir->spec->routes;
    ok($routes, 'routes created');
    like($routes->[0]->match, qr/Host\(`example\.com`\)/, 'host match rule');
    like($routes->[0]->match, qr/Host\(`www\.example\.com`\)/, 'second host');
};

subtest 'traefik: add_backend' => sub {
    my $ir = IO::K8s::Traefik::V1alpha1::IngressRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );
    $ir->spec_push('routes', { match => 'Host(`example.com`)', kind => 'Rule', services => [] });

    $ir->add_backend('api-v1', port => 8080, weight => 90);
    $ir->add_backend('api-v2', port => 8080, weight => 10);
    my $services = $ir->spec->routes->[0]->services;
    is(scalar @$services, 2, 'two backends');
    is($services->[0]->name, 'api-v1', 'first backend name');
    is($services->[0]->weight, 90, 'first backend weight');
    is($services->[1]->name, 'api-v2', 'second backend name');
};

subtest 'traefik: add_path_match' => sub {
    my $ir = IO::K8s::Traefik::V1alpha1::IngressRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );
    $ir->spec_push('routes', {});

    $ir->add_path_match('/api', type => 'Prefix');
    is($ir->spec->routes->[0]->match, 'PathPrefix(`/api`)', 'prefix path match');
};

subtest 'traefik: add_header_match' => sub {
    my $ir = IO::K8s::Traefik::V1alpha1::IngressRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );
    $ir->spec_push('routes', { match => 'Host(`example.com`)' });

    $ir->add_header_match('X-Version' => 'v2');
    like($ir->spec->routes->[0]->match, qr/Header\(`X-Version`, `v2`\)/, 'header match appended');
    like($ir->spec->routes->[0]->match, qr/Host\(`example\.com`\)/, 'original match preserved');
};

# --- Gateway API HTTPRoute ---

# HTTPRoute's spec is a full-depth typed class (k95/D5) as of this suite:
# 'spec' is an HTTPRouteSpec object graph, not an opaque hashref, so these
# subtests build via ->new(metadata => ...) with no 'spec' and let
# add_hostname/add_backend/... seed it through spec_push/spec_set (which
# coerce) -- a direct ->new(spec => {...}) does not coerce a hashref into
# the named nested class (k100), same as the Traefik section above.
# Assertions read back through the typed accessors, not hashref-style
# ->spec->{...} (spec is a blessed HTTPRouteSpec, not a hashref).

subtest 'gateway: add_hostname' => sub {
    my $hr = IO::K8s::GatewayAPI::V1::HTTPRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    $hr->add_hostname('example.com', 'api.example.com');
    is_deeply($hr->spec->hostnames, ['example.com', 'api.example.com'], 'hostnames set');
};

subtest 'gateway: add_backend' => sub {
    my $hr = IO::K8s::GatewayAPI::V1::HTTPRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    $hr->add_backend('api-v1', port => 8080, weight => 90);
    $hr->add_backend('api-v2', port => 8080, weight => 10);
    my $backends = $hr->spec->rules->[0]->backendRefs;
    is(scalar @$backends, 2, 'two backends');
    isa_ok($backends->[0], 'IO::K8s::GatewayAPI::V1::HTTPBackendRef');
    is($backends->[0]->name, 'api-v1', 'first backend');
    is($backends->[0]->weight, 90, 'first weight');
    is($backends->[1]->port, 8080, 'second port');
};

subtest 'gateway: add_path_match' => sub {
    my $hr = IO::K8s::GatewayAPI::V1::HTTPRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    $hr->add_path_match('/api', type => 'Prefix');
    my $matches = $hr->spec->rules->[0]->matches;
    isa_ok($matches->[0], 'IO::K8s::GatewayAPI::V1::HTTPRouteMatch');
    is($matches->[0]->path->type, 'PathPrefix',
        "path type translated from this role's 'Prefix' vocabulary to Gateway API's HTTPPathMatch enum");
    is($matches->[0]->path->value, '/api', 'path value');
};

subtest 'gateway: add_header_match' => sub {
    my $hr = IO::K8s::GatewayAPI::V1::HTTPRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    $hr->add_header_match('X-Version' => 'v2');
    my $headers = $hr->spec->rules->[0]->matches->[0]->headers;
    isa_ok($headers->[0], 'IO::K8s::GatewayAPI::V1::HTTPHeaderMatch');
    is($headers->[0]->name, 'X-Version', 'header name');
    is($headers->[0]->value, 'v2', 'header value');
};

subtest 'gateway: chaining' => sub {
    my $hr = IO::K8s::GatewayAPI::V1::HTTPRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'test-route',
        ),
    );

    my $result = $hr->add_hostname('example.com')
                    ->add_backend('web', port => 80);
    is($result, $hr, 'chaining returns self');
    ok($hr->spec->hostnames, 'hostname set via chain');
    ok($hr->spec->rules->[0]->backendRefs, 'backend set via chain');
};

# --- GRPCRoute ---

subtest 'grpcroute: add_hostname and backend' => sub {
    my $gr = IO::K8s::GatewayAPI::V1::GRPCRoute->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'grpc-route',
        ),
    );

    $gr->add_hostname('grpc.example.com')
       ->add_backend('grpc-service', port => 50051);

    is_deeply($gr->spec->hostnames, ['grpc.example.com'], 'grpc hostname');
    is($gr->spec->rules->[0]->backendRefs->[0]->name, 'grpc-service', 'grpc backend');
};

# --- core Ingress (_route_format 'ingress') ---------------------------------
#
# The third branch, and the one nothing exercised until k117. Two bugs lived
# in it undisturbed because of that: it named IngressRule / IngressBackend /
# ... without loading them (so it only ever worked in a process that had
# loaded them for another reason -- the standalone probe below is what pins
# that), and add_path_match built an HTTPIngressPath without the backend
# upstream requires, croaking only after it had already vivified spec and
# appended a rule.

subtest 'ingress: add_hostname and add_backend' => sub {
    my $ing = IO::K8s::Api::Networking::V1::Ingress->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'web', namespace => 'prod',
        ),
    );
    is($ing->_route_format, 'ingress', 'the ingress branch is under test');

    $ing->add_hostname('example.com', 'api.example.com')
        ->add_backend('api', port => 8080)
        ->add_header_match('X-Env', 'production');    # documented no-op here

    isa_ok($ing->spec, 'IO::K8s::Api::Networking::V1::IngressSpec');
    isa_ok($ing->spec->rules->[0], 'IO::K8s::Api::Networking::V1::IngressRule');
    isa_ok($ing->spec->defaultBackend, 'IO::K8s::Api::Networking::V1::IngressBackend');

    is_deeply($ing->TO_JSON->{spec}, {
        defaultBackend => { service => { name => 'api', port => { number => 8080 } } },
        rules          => [ { host => 'example.com' }, { host => 'api.example.com' } ],
    }, 'the ingress branch emits the typed Ingress shape');
};

subtest 'ingress: add_path_match refuses before it mutates' => sub {
    my $ing = IO::K8s::Api::Networking::V1::Ingress->new(
        metadata => IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new(
            name => 'web', namespace => 'prod',
        ),
    );
    $ing->add_hostname('example.com')->add_backend('api', port => 8080);
    my $before = $ing->TO_JSON;

    throws_ok { $ing->add_path_match('/api', type => 'Prefix') }
        qr/add_path_match cannot build an ingress path/,
        'croaks, naming the method and the reason';
    like($@, qr/requires a backend/, 'and says what upstream demands');

    # The point of the fix: validate, then write. Before k117 this call
    # left spec vivified with an IngressRule carrying an empty http.paths.
    is_deeply($ing->TO_JSON, $before, 'the object is byte-for-byte unchanged');

    # ... including on an object that had nothing to lose yet.
    my $fresh = IO::K8s::Api::Networking::V1::Ingress->new;
    throws_ok { $fresh->add_path_match('/api') }
        qr/add_path_match cannot build an ingress path/, 'same on a fresh object';
    is($fresh->spec, undef, 'and spec was never vivified');
};

subtest 'ingress: the branch works in a process that loads only the Kind' => sub {
    # The regression that matters. Every other test in this file has already
    # pulled half of IO/K8s/Api/Networking into %INC, which is exactly why
    # this bug survived: the branch names its classes without loading them,
    # so it fails only in a bare process. That is what this runs.
    my $probe = <<'PROBE';
use strict;
use warnings;
use IO::K8s::Api::Networking::V1::Ingress;   # and deliberately nothing else
my $ing = IO::K8s::Api::Networking::V1::Ingress->new;
$ing->add_hostname('example.com')->add_backend('api', port => 8080);
my $before = $ing->to_json;
eval { $ing->add_path_match('/api') };
print $@ ? 'CROAK' : 'NO-CROAK';
print '|', ($ing->to_json eq $before ? 'UNCHANGED' : 'MUTATED');
print '|', $before;
PROBE
    my $fh = File::Temp->new(SUFFIX => '.pl');
    print $fh $probe;
    close $fh;
    my $out = qx{"$^X" -Ilib "$fh" 2>&1};
    is($?, 0, 'the probe exits clean') or diag($out);

    my ($croaked, $mutated, $json) = split /\|/, $out, 3;
    is($croaked, 'CROAK', 'add_path_match still refuses in a bare process');
    is($mutated, 'UNCHANGED', 'and still leaves the object alone');
    is_deeply(JSON::MaybeXS->new->decode($json // '{}')->{spec}, {
        defaultBackend => { service => { name => 'api', port => { number => 8080 } } },
        rules          => [ { host => 'example.com' } ],
    }, 'add_hostname/add_backend built the full typed shape with nothing preloaded');
};

done_testing;
