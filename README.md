# IO::K8s

Perl objects representing the Kubernetes API (v1.37).

## Description

This module provides Perl objects and serialization/deserialization methods that represent the structures found in the Kubernetes API (v1.37).

Kubernetes API is strict about input types. When a value is expected to be an integer, sending it as a string will cause rejection. This module ensures correct value types in JSON that can be sent to Kubernetes.

It also inflates JSON returned by Kubernetes into typed Perl objects.

## Installation

From CPAN:

```bash
cpanm IO::K8s
```

From source:

```bash
cpanm --installdeps .
dzil build
dzil test
```

## Usage

```perl
use IO::K8s;

my $k8s = IO::K8s->new;

# Create objects with short names
my $pod = $k8s->new_object('Pod',
    metadata => { name => 'my-pod', namespace => 'default' },
    spec => { containers => [{ name => 'app', image => 'nginx' }] }
);

# Load and validate YAML manifests
my $resources = $k8s->load_yaml('deployment.yaml');

# Save to YAML file
$pod->save('pod.yaml');

# Inflate JSON/struct into typed objects (auto-detect class from 'kind')
my $svc = $k8s->json_to_object('Service', '{"kind":"Service"}');
my $obj = $k8s->inflate({ kind => 'Pod', metadata => { name => 'test' } });

# Serialize back to JSON
my $json = $k8s->object_to_json($svc);
my $struct = $k8s->object_to_struct($pod);
```

### Multi-version dispatch

`inflate()` resolves a `kind` to the right class by inspecting the
incoming `apiVersion`. For Kubernetes Kinds that ship at more than one
API version (e.g. `DeviceClass`, `ResourceClaim`,
`ResourceClaimTemplate`, `ResourceSlice` under `resource.k8s.io` across
`v1`, `v1beta1`, `v1beta2`), every shipped version is registered so a
manifest is inflated as the schema version that produced it:

```perl
my $v1beta1 = $k8s->inflate({
    apiVersion => 'resource.k8s.io/v1beta1',
    kind       => 'DeviceClass',
    metadata   => { name => 'gold' },
    spec       => { selectors => [] },
});
# $v1beta1 is IO::K8s::Api::Resource::V1beta1::DeviceClass,
# not IO::K8s::Api::Resource::V1::DeviceClass. Round-trip preserves
# the apiVersion.

my $ga = $k8s->inflate({
    apiVersion => 'resource.k8s.io/v1',
    kind       => 'DeviceClass',
    metadata   => { name => 'silver' },
    spec       => { selectors => [] },
});
# $ga is IO::K8s::Api::Resource::V1::DeviceClass (GA).
```

The wire `apiVersion` emitted by `TO_JSON` is derived from each
class's package name via `IO::K8s::Role::APIObject` and an explicit
group map covering the 15 groups whose CamelCase lc-form is not the
upstream group name (e.g. `storagemigration` →
`storagemigration.k8s.io`, `apiserverinternal` →
`internal.apiserver.k8s.io`). Serialised manifests therefore carry the
apiVersion a real cluster expects.

## Bundled CRD Providers

IO::K8s ships with CRD classes for popular Kubernetes ecosystem projects. None are loaded by default - opt in at construction:

```perl
my $k8s = IO::K8s->new(with => [
    'IO::K8s::Cilium',
    'IO::K8s::Traefik',
    'IO::K8s::CertManager',
    'IO::K8s::K3s',
    'IO::K8s::GatewayAPI',
    'IO::K8s::AgentSandbox',
]);
```

### Cilium (30 CRDs)

`IO::K8s::Cilium` covers `cilium.io/v2` and `cilium.io/v2alpha1` (upstream v1.20.0):

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::Cilium']);
my $cnp = $k8s->new_object('CiliumNetworkPolicy',
    metadata => { name => 'allow-dns', namespace => 'kube-system' },
    spec => { endpointSelector => {} },
);
```

### Traefik (10 CRDs)

`IO::K8s::Traefik` covers `traefik.io/v1alpha1`:

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::Traefik']);
my $ir = $k8s->new_object('IngressRoute',
    metadata => { name => 'my-route', namespace => 'default' },
    spec => { entryPoints => ['web'], routes => [{ match => 'Host(`example.com`)' }] },
);
```

### cert-manager (6 CRDs)

`IO::K8s::CertManager` covers `cert-manager.io/v1` and `acme.cert-manager.io/v1`:

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::CertManager']);
my $cert = $k8s->new_object('Certificate',
    metadata => { name => 'my-cert', namespace => 'default' },
    spec => { secretName => 'my-cert-tls', issuerRef => { name => 'letsencrypt' } },
);
```

### K3s (4 CRDs)

`IO::K8s::K3s` covers `helm.cattle.io/v1` and `k3s.cattle.io/v1` (upstream v1.36.3+k3s1):

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::K3s']);
my $hc = $k8s->new_object('HelmChart',
    metadata => { name => 'traefik', namespace => 'kube-system' },
    spec => { chart => 'traefik' },
);
```

### Gateway API (11 CRDs)

`IO::K8s::GatewayAPI` covers `gateway.networking.k8s.io/v1` and `gateway.networking.k8s.io/v1beta1` (upstream v1.6.1, GA/Standard channel only):

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::GatewayAPI']);
my $gw = $k8s->new_object('Gateway',
    metadata => { name => 'my-gateway', namespace => 'default' },
    spec => { gatewayClassName => 'istio', listeners => [{ name => 'http', port => 80 }] },
);
```

### AgentSandbox (4 CRDs in 8 modules: v1alpha1 + v1beta1)

`IO::K8s::AgentSandbox` covers `agents.x-k8s.io/{v1alpha1,v1beta1}` and `extensions.agents.x-k8s.io/{v1alpha1,v1beta1}` (upstream v0.5.4; v1beta1 is the storage version, v1alpha1 remains served):

```perl
my $k8s = IO::K8s->new(with => ['IO::K8s::AgentSandbox']);
my $sandbox = $k8s->new_object('Sandbox',
    metadata => { name => 'my-sandbox', namespace => 'default' },
    spec => { replicas => 1, shutdownPolicy => 'Retain' },
);
```

## Convenience Roles

All API objects automatically get label, annotation, condition, and owner reference methods:

```perl
# Labels & annotations (all API objects)
$pod->add_label(app => 'web');
$pod->add_labels(app => 'web', tier => 'frontend');
$pod->has_label('app');            # true
$pod->match_labels(app => 'web');  # true
$pod->add_annotation('prometheus.io/scrape' => 'true');

# Status conditions (objects with status)
$deploy->is_ready;
$deploy->is_condition_true('Available');
$deploy->condition_message('Progressing');

# Owner references
$pod->set_owner($deployment);
$pod->is_owned_by($deployment);
```

CRD classes automatically get deep-path spec manipulation via `SpecBuilder`:

```perl
$ir->spec_set('tls.secretName', 'my-cert');
$ir->spec_get('routes.0.match');
$ir->spec_push('routes', { match => 'Host(`api.example.com`)' });
$ir->spec_merge(entryPoints => ['web', 'websecure']);
$ir->spec_delete('tls');
```

Domain-specific builder roles provide fluent APIs for common tasks:

```perl
# Network policies (core K8s + Cilium)
$netpol->select_pods(app => 'web')
       ->allow_ingress_from_pods({ app => 'nginx' }, ports => [{ port => 8080 }])
       ->allow_egress_to_dns
       ->deny_all_egress;

# HTTP routing (Ingress, HTTPRoute, IngressRoute)
$route->add_hostname('example.com')
      ->add_backend('api-v1', port => 8080, weight => 90)
      ->add_path_match('/api', type => 'Prefix');

# cert-manager
$cert->for_domains('example.com', '*.example.com')
     ->with_issuer('letsencrypt-prod', kind => 'ClusterIssuer')
     ->store_in_secret('example-tls');

# K3s Helm charts
$chart->from_repo('https://traefik.github.io/charts', 'traefik')
      ->set_version('25.0.0')
      ->set_values(replicas => 3);

# Traefik middleware
$mw->rate_limit(average => 100, burst => 200)
   ->strip_prefix('/api')
   ->redirect_https;
```

### IP Type Validation

`IO::K8s::Types::Net` provides Net::IP-backed type constraints:

```perl
use IO::K8s::Types::Net qw( IPv4 IPv6 IPAddress CIDR NetIP );
use IO::K8s::Types::Net qw( parse_ip cidr_contains is_rfc1918 );

cidr_contains('10.0.0.0/8', '10.1.2.3');  # true
is_rfc1918('192.168.1.1');                 # true
```

## External Resource Maps

Merge resource maps from external packages (e.g. `IO::K8s::Cilium` or your own CRD packages):

```perl
# At construction time
my $k8s = IO::K8s->new(with => ['IO::K8s::Cilium']);

# Or at runtime
$k8s->add('IO::K8s::Cilium');

# Disambiguate colliding kind names with domain-qualified strings
$k8s->new_object('cilium.io/v2/CiliumNetworkPolicy', { ... });

# Or with api_version parameter
$k8s->new_object('CiliumNetworkPolicy', { ... }, 'cilium.io/v2');

# inflate() auto-uses apiVersion from JSON data
$k8s->inflate('{"kind":"CiliumNetworkPolicy","apiVersion":"cilium.io/v2",...}');
```

### pk8s DSL

In `.pk8s` manifest files, Cilium kinds work directly:

```perl
CiliumNetworkPolicy {
    name => 'allow-dns',
    namespace => 'kube-system',
    spec => { endpointSelector => {} },
};

CiliumNode {
    name => 'worker-1',
    spec => { addresses => [{ type => 'InternalIP', ip => '10.0.0.1' }] },
};
```

Note: `.pk8s` manifests are Perl code, not data — they are executed
in-process via `eval` when loaded, so only load them from sources you
trust. For data-only manifests (YAML/JSON), use `load_yaml`, which parses
without executing code.

## Custom Resource Definitions (CRDs)

Write your own CRD classes using `IO::K8s::APIObject`:

```perl
package My::StaticWebSite;
use IO::K8s::APIObject
    api_version     => 'homelab.example.com/v1',
    resource_plural => 'staticwebsites';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };
1;
```

Or generate them dynamically from an OpenAPI schema using `IO::K8s::AutoGen`.

See the full POD documentation for details on the class architecture and CRD support.

## Removed classes

Several class names that existed in the pre-1.000 series are no longer
shipped. The list lives in `IO::K8s::Deprecated`'s POD (install it from
CPAN — it provides a redirect message pointing at the modern
replacement). Highlights:

- The 76 `*List` classes (`PodList`, `ServiceList`, `DeploymentList`,
  ...) have not been real classes since the 1.00 Moose-to-Moo rewrite.
  Use `IO::K8s::List` to inflate any List-shaped payload.
- Four namespaces held nothing but a `*List` stub and were removed
  entirely in 1.105: `IO::K8s::ApiExtensionsApiServer`,
  `IO::K8s::Api::Auditregistration`, `IO::K8s::Api::Extensions`,
  `IO::K8s::Api::Settings`.

The full old-name list and the redirect target for each is in
`IO::K8s::Deprecated`.

## Migration notes

If you are upgrading from a pre-1.100 release:

- **1.000 → 1.105 (2026-08-08):** Kubernetes core moved from v1.31 to
  v1.36, the bundled CRD providers moved to their current upstream
  versions (Cilium v1.20.0, K3s v1.36.3+k3s1, Traefik v3.7.10,
  cert-manager v1.21.1, Gateway API v1.6.1, Agent Sandbox v0.5.4).
  The 76 `*List` classes were removed; the four stub-only namespaces
  above were dropped.
- **1.105 → current:** `inflate()` now honours `apiVersion` for every
  shipped multi-version Kind (k11). `api_version()` now produces
  the correct wire `apiVersion` for `storagemigration.k8s.io` and
  `internal.apiserver.k8s.io` (k13); before the fix, manifests
  serialised for these two groups were rejected by the API server.
  The release between 1.105 and now also carried a substantial body of
  behaviour changes worth knowing about before upgrading:
  - **Upstream sync to v1.37** (k72) — 22 new Kinds, a new
    `IO::K8s::Api::Lifecycle` namespace, and ten fields upstream made
    required are now required at construction.
  - **Seven embedded template classes** (`PodTemplateSpec`,
    `JobTemplateSpec`, `PersistentVolumeClaimTemplate`,
    `ResourceClaimTemplateSpec` × 4 versions) no longer compose
    `IO::K8s::APIObject` (k45), so `kind()`, `api_version()`,
    `add_label()` and the rest of the role are gone from their
    instances. Use the role on a wrapping object instead.
  - **`set_owner()` became strict** (k47): owners without a `uid` are
    refused; `controller` is now an explicit parameter (default 1);
    a second controller reference or a duplicate owner is rejected
    rather than silently written.
  - **Booleans stop inventing `false` from `undef`** (k48); an explicit
    `undef` now omits the field, matching the inflation path.
  - **`FROM_HASH` is now strict and recursive** (k59) — every class is
    `to_json` / `from_json` symmetric; raw nested hashrefs that used to
    be refused are now inflated.
  - **`kind()` and `api_version()` croak on an argument** (k67, k70) —
    they are derived read-only identity accessors and silently
    swallowing an argument was the source of hidden bugs.
  - **`resource_plural()` croaks on an argument** too (k70), in the
    three spots it lives (role accessor, `APIObject` import param,
    AutoGen GVK constant).
  See `Changes` for the full k33–k72 history.

Code that still references one of the 76 removed `*List` class names
will fail to install; install `IO::K8s::Deprecated` from CPAN for a
clear redirect message.

## Features

- Support for Kubernetes v1.37 API objects
- Type-safe object creation and serialization
- Lightweight Moo-based implementation
- Handles all Kubernetes resource types (Pods, Services, Deployments, etc.)
- Custom Resource Definition (CRD) support with `IO::K8s::APIObject` import parameters
- External resource map support with collision handling (`add()`, `with` constructor param)
- Domain-qualified resource names for disambiguation (`api_version/Kind`)
- Dynamic class generation from OpenAPI schemas via `IO::K8s::AutoGen`
- Convenience methods: labels, annotations, conditions, owner references on all API objects
- Deep-path spec manipulation for CRD classes via `SpecBuilder`
- Domain-specific builder roles for network policies, routing, certificates, Helm, and more
- Net::IP-backed IP/CIDR type constraints (`IO::K8s::Types::Net`)
- Proper handling of namespaced resources
- Canonical JSON output for consistent API requests

## Links

- CPAN: https://metacpan.org/pod/IO::K8s
- GitHub: https://github.com/pplu/io-k8s-p5
- Issues: https://github.com/pplu/io-k8s-p5/issues
- Kubernetes API Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.37/

## Authors

- Torsten Raudssus <getty@cpan.org>
- Jose Luis Martinez Torres <jlmartin@cpan.org> (original author, inactive)

## License

Copyright (c) 2018-2026 by Jose Luis Martinez Torres

This code is distributed under the Apache 2 License. The full text of the license can be found in the LICENSE file included with this module.

## Support

- Issues: https://github.com/pplu/io-k8s-p5/issues

## See Also

- [Kubernetes::REST](https://metacpan.org/pod/Kubernetes::REST) - Kubernetes REST API client
- [IO::K8s::Resource](https://metacpan.org/pod/IO::K8s::Resource) - Base class for all Kubernetes resources
- [IO::K8s::APIObject](https://metacpan.org/pod/IO::K8s::APIObject) - The `k8s` DSL for declaring API classes
- [IO::K8s::List](https://metacpan.org/pod/IO::K8s::List) - List-typed inflation (`PodList`, `ServiceList`, ...)
- [IO::K8s::AutoGen](https://metacpan.org/pod/IO::K8s::AutoGen) - Generate classes at runtime from an OpenAPI schema
- [IO::K8s::Deprecated](https://metacpan.org/pod/IO::K8s::Deprecated) - Redirects for class names removed in 1.000+
- [IO::K8s::Types::Net](https://metacpan.org/pod/IO::K8s::Types::Net) - Net::IP-backed type constraints
