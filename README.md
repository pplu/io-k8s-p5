# IO::K8s

Perl objects representing the Kubernetes API (v1.31).

## Description

This module provides Perl objects and serialization/deserialization methods that represent the structures found in the Kubernetes API (v1.31).

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
dzil install
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

## Features

- Support for Kubernetes v1.31 API objects
- Type-safe object creation and serialization
- Lightweight Moo-based implementation
- Handles all Kubernetes resource types (Pods, Services, Deployments, etc.)
- Proper handling of namespaced resources
- Canonical JSON output for consistent API requests

## Links

- CPAN: https://metacpan.org/pod/IO::K8s
- GitHub: https://github.com/pplu/io-k8s-p5
- Issues: https://github.com/pplu/io-k8s-p5/issues
- Kubernetes API Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/

## Authors

- Torsten Raudssus <torsten@raudssus.de>
- Jose Luis Martinez <jlmartinez@capside.com> (original author, inactive)

## License

Copyright (c) 2018 by CAPSiDE

This code is distributed under the Apache 2 License. The full text of the license can be found in the LICENSE file included with this module.

## Support

- IRC: #kubernetes on irc.perl.org
- Issues: https://github.com/pplu/io-k8s-p5/issues

## See Also

- [Kubernetes::REST](https://metacpan.org/pod/Kubernetes::REST) - Kubernetes REST API client
- [IO::K8s::Resource](https://metacpan.org/pod/IO::K8s::Resource) - Base class for all Kubernetes resources
