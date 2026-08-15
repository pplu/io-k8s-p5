#!/usr/bin/env perl
# karr #33: IO::K8s::Role::APIObject::resource_plural used to return undef
# for every shipped Kubernetes class, so consumers that need Kind -> plural
# (RBAC speaks plurals, the API speaks Kinds) fell back to an lc+"s"
# heuristic. A wrong plural there is indistinguishable from a denied
# permission, so the plurals now come from a table generated off the
# upstream spec's REST paths (maint/spec-resource-plural-gen.pl) rather than
# from any string transformation.
#
# What these tests claim:
#   * the non-derivable plurals are right (this is the whole point -- every
#     one of them breaks lc+"s")
#   * the lookup is keyed on group+version+Kind, not on the bare Kind
#   * anything without a plural stays undef and is never guessed
#   * an explicit per-class resource_plural (CRD import, AutoGen option, a
#     hand-written sub) still wins over the central table
#   * class_namespaces subclasses inherit through @ISA, like api_version
#
# Pure local fixtures -- no network, no cluster.

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use IO::K8s;

# ----------------------------------------------------------------------------
# Test-local classes
# ----------------------------------------------------------------------------

# A class_namespaces subclass of a built-in, plus a second level, to
# exercise the recursive @ISA walk. Seeded into %INC so IO::K8s::load_class
# treats them as loaded.
{
    package My::K8s::Api::Core::V1::Pod;
    use parent qw(IO::K8s::Api::Core::V1::Pod);
    BEGIN { $INC{'My/K8s/Api/Core/V1/Pod.pm'} = __FILE__ }
}
{
    # -norequire: the parent is this same file, compiled just above.
    package My::K8s::Deep::Pod;
    use parent -norequire, 'My::K8s::Api::Core::V1::Pod';
}

# A subclass that declares its own plural: an explicit value must beat the
# one it would otherwise inherit from the built-in table.
{
    package My::K8s::Override::Pod;
    use parent qw(IO::K8s::Api::Core::V1::Pod);
    sub resource_plural { 'mypods' }
}

# A CRD declared the documented way (lib/IO/K8s.pm CRD contract).
{
    package My::K8s::StaticWebSite;
    use IO::K8s::APIObject
        api_version     => 'homelab.example.com/v1',
        resource_plural => 'staticwebsites';
    k8s spec => { Str => 1 };
}

# A CRD that declares no plural at all: still undef, never guessed.
{
    package My::K8s::Unplural;
    use IO::K8s::APIObject api_version => 'homelab.example.com/v1';
    k8s spec => { Str => 1 };
}

# ----------------------------------------------------------------------------

subtest 'plurals that no lc+"s" heuristic can produce' => sub {
    my %expected = (
        'IO::K8s::Api::Core::V1::Endpoints'           => 'endpoints',
        'IO::K8s::Api::Networking::V1::NetworkPolicy' => 'networkpolicies',
        'IO::K8s::Api::Networking::V1::Ingress'       => 'ingresses',
        'IO::K8s::Api::Scheduling::V1::PriorityClass' => 'priorityclasses',
        'IO::K8s::Api::Storage::V1::StorageClass'     => 'storageclasses',
        'IO::K8s::Api::Core::V1::ComponentStatus'     => 'componentstatuses',
        'IO::K8s::Api::Storage::V1::CSIStorageCapacity' => 'csistoragecapacities',
        'IO::K8s::Api::Node::V1::RuntimeClass'        => 'runtimeclasses',
        'IO::K8s::Api::Resource::V1::DeviceClass'     => 'deviceclasses',
        'IO::K8s::Api::Networking::V1::IPAddress'     => 'ipaddresses',
    );

    for my $class (sort keys %expected) {
        IO::K8s->load_class($class);
        my $want = $expected{$class};
        is($class->resource_plural, $want, "$class -> $want (class method)");

        # And the heuristic this replaces really would have been wrong.
        my $naive = lc($class->kind) . 's';
        isnt($naive, $want, "  lc+'s' would have produced '$naive'");
    }
};

subtest 'plurals a heuristic happens to get right are still correct' => sub {
    my %expected = (
        'IO::K8s::Api::Core::V1::Pod'          => 'pods',
        'IO::K8s::Api::Core::V1::Secret'       => 'secrets',
        'IO::K8s::Api::Apps::V1::Deployment'   => 'deployments',
        'IO::K8s::Api::Apps::V1::StatefulSet'  => 'statefulsets',
        'IO::K8s::Api::Batch::V1::CronJob'     => 'cronjobs',
        'IO::K8s::Api::Rbac::V1::ClusterRole'  => 'clusterroles',
        'IO::K8s::Api::Rbac::V1::RoleBinding'  => 'rolebindings',
    );
    for my $class (sort keys %expected) {
        IO::K8s->load_class($class);
        is($class->resource_plural, $expected{$class},
            "$class -> $expected{$class}");
    }
};

subtest 'instance method agrees with class method' => sub {
    IO::K8s->load_class('IO::K8s::Api::Networking::V1::Ingress');
    my $ingress = IO::K8s::Api::Networking::V1::Ingress->new;
    is($ingress->resource_plural, 'ingresses', 'instance -> ingresses');
    is($ingress->resource_plural, IO::K8s::Api::Networking::V1::Ingress->resource_plural,
        'instance and class method agree');
};

subtest 'lookup is keyed on group+version+Kind, not the bare Kind' => sub {
    IO::K8s->load_class('IO::K8s::Api::Core::V1::Event');
    IO::K8s->load_class('IO::K8s::Api::Events::V1::Event');

    is(IO::K8s::Api::Core::V1::Event->api_version, 'v1', 'core Event apiVersion');
    is(IO::K8s::Api::Events::V1::Event->api_version, 'events.k8s.io/v1',
        'events.k8s.io Event apiVersion');

    # Same Kind name, two groups: each resolves through its own table entry.
    is(IO::K8s::Api::Core::V1::Event->resource_plural, 'events',
        'core/v1 Event -> events');
    is(IO::K8s::Api::Events::V1::Event->resource_plural, 'events',
        'events.k8s.io/v1 Event -> events');

    # A Kind whose exact GVK upstream v1.36 no longer serves gets nothing,
    # even though the same Kind in a newer version of the same group does.
    # That is the fail-closed half of the design: no cross-version or
    # cross-group borrowing, because a borrowed plural is a guess.
    IO::K8s->load_class('IO::K8s::Api::Resource::V1::ResourceClaim');
    IO::K8s->load_class('IO::K8s::Api::Resource::V1alpha3::ResourceClaim');
    is(IO::K8s::Api::Resource::V1::ResourceClaim->resource_plural, 'resourceclaims',
        'resource.k8s.io/v1 ResourceClaim -> resourceclaims');
    is(IO::K8s::Api::Resource::V1alpha3::ResourceClaim->resource_plural, undef,
        'resource.k8s.io/v1alpha3 ResourceClaim -> undef (GVK not in the spec)');
};

subtest 'subresources have no plural of their own' => sub {
    # pods/eviction, deployments/scale, serviceaccounts/token: RBAC names
    # these as a subresource of their parent, never as a resource.
    my %subresource = (
        'IO::K8s::Api::Policy::V1::Eviction'             => 'Eviction',
        'IO::K8s::Api::Autoscaling::V1::Scale'           => 'Scale',
        'IO::K8s::Api::Authentication::V1::TokenRequest' => 'TokenRequest',
    );
    for my $class (sort keys %subresource) {
        IO::K8s->load_class($class);
        is($class->resource_plural, undef, "$subresource{$class} -> undef");
    }
};

subtest 'embedded template types have no plural' => sub {
    # These carry metadata (so they compose Role::APIObject) but have no
    # x-kubernetes-group-version-kind and never appear as a 'kind:' on the
    # wire -- same reason they are absent from %DEFAULT_RESOURCE_MAP.
    for my $class (qw(
        IO::K8s::Api::Core::V1::PodTemplateSpec
        IO::K8s::Api::Core::V1::PersistentVolumeClaimTemplate
        IO::K8s::Api::Batch::V1::JobTemplateSpec
    )) {
        IO::K8s->load_class($class);
        is($class->resource_plural, undef, "$class -> undef");
    }
};

subtest 'explicit per-class resource_plural wins' => sub {
    # 1. Shipped CRD class (Cilium declares its own at import time)
    IO::K8s->load_class('IO::K8s::Cilium::V2alpha1::CiliumEndpointSlice');
    is(IO::K8s::Cilium::V2alpha1::CiliumEndpointSlice->resource_plural,
        'ciliumendpointslices', 'Cilium CRD keeps its declared plural');
    IO::K8s->load_class('IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool');
    is(IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool->new->resource_plural,
        'ciliumloadbalancerippools', 'Cilium CRD instance too');

    # 2. User CRD via the documented import parameters
    is(My::K8s::StaticWebSite->resource_plural, 'staticwebsites',
        'user CRD import parameter');

    # 3. A hand-written override on a subclass of a built-in beats the
    #    plural the subclass would otherwise inherit through @ISA.
    is(IO::K8s::Api::Core::V1::Pod->resource_plural, 'pods', 'parent still pods');
    is(My::K8s::Override::Pod->resource_plural, 'mypods',
        'subclass override wins over the inherited table value');

    # 4. A CRD that declares nothing stays undef -- never guessed from the
    #    class name.
    is(My::K8s::Unplural->resource_plural, undef,
        'CRD without a declared plural -> undef');
};

subtest 'AutoGen resource_plural option wins' => sub {
    require IO::K8s::AutoGen;
    my %defs = (
        'com.example.v1.Widget' => {
            type       => 'object',
            properties => { spec => { type => 'object' } },
        },
    );
    my $class = IO::K8s::AutoGen::get_or_generate(
        'com.example.v1.Widget', $defs{'com.example.v1.Widget'}, \%defs,
        'IO::K8s::_AUTOGEN',
        api_version     => 'example.com/v1',
        kind            => 'Widget',
        resource_plural => 'widgeten',
    );
    is($class->resource_plural, 'widgeten', 'AutoGen option installs the plural');
};

subtest 'class_namespaces subclasses inherit through @ISA' => sub {
    is(My::K8s::Api::Core::V1::Pod->api_version, 'v1',
        'subclass inherits api_version (existing behaviour)');
    is(My::K8s::Api::Core::V1::Pod->resource_plural, 'pods',
        'subclass inherits the plural the same way');
    is(My::K8s::Deep::Pod->resource_plural, 'pods',
        'two levels up the @ISA chain still resolves');

    # And through the real resolution path a consumer uses.
    my $k8s = IO::K8s->new(class_namespaces => ['My::K8s']);
    my $class = $k8s->expand_class('Pod');
    is($class, 'My::K8s::Api::Core::V1::Pod', 'expand_class picks the subclass');
    is($class->resource_plural, 'pods', 'and it reports the built-in plural');

    my $obj = $k8s->new_object('Pod');
    isa_ok($obj, 'My::K8s::Api::Core::V1::Pod', 'new_object');
    is($obj->resource_plural, 'pods', 'inflated subclass instance -> pods');
};

subtest 'coverage over the default resource map' => sub {
    # Regression guard for a bad regeneration: every short name in the
    # built-in map must resolve to a plural except the three subresources.
    my $map = IO::K8s->default_resource_map;
    my @short = grep { !m{/} } sort keys %$map;

    my @without;
    for my $kind (@short) {
        my $class = IO::K8s->expand_class($kind);
        IO::K8s->load_class($class);
        push @without, $kind unless defined $class->resource_plural;
    }

    is_deeply(\@without, [qw(Eviction Scale TokenRequest)],
        'exactly the three subresources have no plural');
    is(scalar(@short) - scalar(@without), 75,
        '75 of the 78 short names carry an upstream plural');
};

done_testing;
