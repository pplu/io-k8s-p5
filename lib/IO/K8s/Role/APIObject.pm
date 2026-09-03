package IO::K8s::Role::APIObject;
# ABSTRACT: Role for top-level Kubernetes API objects
our $VERSION = '1.108';
use Moo::Role;
use Types::Standard qw( InstanceOf Maybe );
use Scalar::Util qw(blessed);
use Carp qw( croak );

has metadata => (
    is => 'rw',
    isa => Maybe[InstanceOf['IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta']],
);

=attr metadata

Standard object's metadata. See L<IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta>.

=cut

# Map IO::K8s short group names to full Kubernetes API group names
my %API_GROUP_MAP = (
    rbac                  => 'rbac.authorization.k8s.io',
    networking            => 'networking.k8s.io',
    storage               => 'storage.k8s.io',
    admissionregistration => 'admissionregistration.k8s.io',
    certificates          => 'certificates.k8s.io',
    coordination          => 'coordination.k8s.io',
    events                => 'events.k8s.io',
    scheduling            => 'scheduling.k8s.io',
    authentication        => 'authentication.k8s.io',
    authorization         => 'authorization.k8s.io',
    node                  => 'node.k8s.io',
    discovery             => 'discovery.k8s.io',
    flowcontrol           => 'flowcontrol.apiserver.k8s.io',
    resource              => 'resource.k8s.io',
    apiserverinternal     => 'internal.apiserver.k8s.io',
    storagemigration      => 'storagemigration.k8s.io',
    lifecycle             => 'lifecycle.k8s.io',
);

# Derive apiVersion from a class-name string in a known namespace:
# IO::K8s::Api::Core::V1::Pod -> v1
# IO::K8s::Api::Apps::V1::Deployment -> apps/v1
# IO::K8s::Api::Rbac::V1::Role -> rbac.authorization.k8s.io/v1
# IO::K8s::ApiextensionsApiserver::...::V1::CustomResourceDefinition -> apiextensions.k8s.io/v1
# IO::K8s::KubeAggregator::...::V1::APIService -> apiregistration.k8s.io/v1
sub _api_version_from_class {
    my ($class) = @_;

    # Standard API: IO::K8s::Api::Group::Version::Kind
    if ($class =~ /^IO::K8s::Api::(\w+)::(\w+)::/) {
        my ($group, $version) = ($1, $2);
        $version = lc($version);
        return $version if $group eq 'Core';
        my $group_lc = lc($group);
        return ($API_GROUP_MAP{$group_lc} // $group_lc) . '/' . $version;
    }

    # Apiextensions: IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::Version::Kind
    if ($class =~ /^IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::(\w+)::/) {
        return 'apiextensions.k8s.io/' . lc($1);
    }

    # KubeAggregator: IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::Version::Kind
    if ($class =~ /^IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::(\w+)::/) {
        return 'apiregistration.k8s.io/' . lc($1);
    }

    return undef;
}

# Kind -> plural resource name. Two generated tables, looked up in this
# order by _resource_plural_from_class() below:
#
#   1. %RESOURCE_PLURAL           keyed "$api_version/$Kind"
#   2. %RESOURCE_PLURAL_BY_GROUP  keyed "$group|$Kind"
#
# Tier 1 is the exact GVK: the same domain-qualified key shape as
# %DEFAULT_RESOURCE_MAP's qualified keys in IO::K8s, and exactly what
# api_version() below returns joined to kind(). The group is folded into the
# api_version, so core/v1 Event and events.k8s.io/v1 Event stay distinct
# entries. It is consulted first because it is the more specific fact and
# keeps the exact-GVK answer authoritative.
#
# Tier 2 is the GroupResource, and it is the *correct* key for the consumer
# this exists for rather than a loosening of tier 1: RBAC addresses
# resources by apiGroups + resources, with no version in the rule at all, so
# the plural is a property of the group and the Kind. It covers the shipped
# classes that sit on API tracks upstream no longer serves
# (resource.k8s.io/v1alpha3, flowcontrol.apiserver.k8s.io/v1beta3,
# storage.k8s.io/v1alpha1, ...), which have no tier-1 key of their own but
# whose served siblings do. Core is a group of its own (the empty group), so
# core Event and events.k8s.io Event stay distinct here too -- this is
# group+Kind, never a bare Kind, and the generator only emits an entry when
# every version of that group in the spec agrees on the plural (k36).
#
# Generated, not hand-written: the plural is not derivable from the Kind
# (Endpoints -> endpoints, NetworkPolicy -> networkpolicies, Ingress ->
# ingresses, PriorityClass -> priorityclasses), but it is authoritative in
# the upstream spec's REST paths. maint/spec-resource-plural-gen.pl reads it
# off there and rewrites both blocks below; do not edit them by hand.
#
# Central rather than per-class for the same reason api_version is: one
# table beats writing a literal into ~180 shipped classes, and the @ISA
# fallback then gives class_namespaces subclasses the plural for free. An
# explicit per-class resource_plural -- a CRD's
# `use IO::K8s::APIObject resource_plural => ...`, or IO::K8s::AutoGen's
# option -- is installed into the package *before* this role is composed,
# so it still wins over everything here.
#
# Absent on purpose from both tables, and staying undef: subresources
# (Eviction, Scale, TokenRequest -- addressed as pods/eviction,
# deployments/scale, serviceaccounts/token, never as a resource of their
# own), the embedded *Template / *TemplateSpec types that have no GVK at
# all, and any Kind the spec has no collection endpoint for anywhere in its
# group. A miss in both tiers returns undef; nothing falls back to a guess,
# because a wrong plural is indistinguishable from a denied permission at
# the RBAC layer, which is the whole reason these tables exist (k33).
# --- BEGIN GENERATED resource plural table (v1.37.0) ---
# Regenerate with: maint/spec-resource-plural-gen.pl --spec spec/v1.37.0.json
my %RESOURCE_PLURAL = (
    # core
    'v1/Binding'               => 'bindings',
    'v1/ComponentStatus'       => 'componentstatuses',
    'v1/ConfigMap'             => 'configmaps',
    'v1/Endpoints'             => 'endpoints',
    'v1/Event'                 => 'events',
    'v1/LimitRange'            => 'limitranges',
    'v1/Namespace'             => 'namespaces',
    'v1/Node'                  => 'nodes',
    'v1/PersistentVolume'      => 'persistentvolumes',
    'v1/PersistentVolumeClaim' => 'persistentvolumeclaims',
    'v1/Pod'                   => 'pods',
    'v1/PodTemplate'           => 'podtemplates',
    'v1/ReplicationController' => 'replicationcontrollers',
    'v1/ResourceQuota'         => 'resourcequotas',
    'v1/Secret'                => 'secrets',
    'v1/Service'               => 'services',
    'v1/ServiceAccount'        => 'serviceaccounts',

    # admissionregistration.k8s.io
    'admissionregistration.k8s.io/v1/MutatingAdmissionPolicy'              => 'mutatingadmissionpolicies',
    'admissionregistration.k8s.io/v1/MutatingAdmissionPolicyBinding'       => 'mutatingadmissionpolicybindings',
    'admissionregistration.k8s.io/v1/MutatingWebhookConfiguration'         => 'mutatingwebhookconfigurations',
    'admissionregistration.k8s.io/v1/ValidatingAdmissionPolicy'            => 'validatingadmissionpolicies',
    'admissionregistration.k8s.io/v1/ValidatingAdmissionPolicyBinding'     => 'validatingadmissionpolicybindings',
    'admissionregistration.k8s.io/v1/ValidatingWebhookConfiguration'       => 'validatingwebhookconfigurations',
    'admissionregistration.k8s.io/v1alpha1/MutatingAdmissionPolicy'        => 'mutatingadmissionpolicies',
    'admissionregistration.k8s.io/v1alpha1/MutatingAdmissionPolicyBinding' => 'mutatingadmissionpolicybindings',
    'admissionregistration.k8s.io/v1beta1/MutatingAdmissionPolicy'         => 'mutatingadmissionpolicies',
    'admissionregistration.k8s.io/v1beta1/MutatingAdmissionPolicyBinding'  => 'mutatingadmissionpolicybindings',

    # apiextensions.k8s.io
    'apiextensions.k8s.io/v1/CustomResourceDefinition' => 'customresourcedefinitions',

    # apiregistration.k8s.io
    'apiregistration.k8s.io/v1/APIService' => 'apiservices',

    # apps
    'apps/v1/ControllerRevision' => 'controllerrevisions',
    'apps/v1/DaemonSet'          => 'daemonsets',
    'apps/v1/Deployment'         => 'deployments',
    'apps/v1/ReplicaSet'         => 'replicasets',
    'apps/v1/StatefulSet'        => 'statefulsets',

    # authentication.k8s.io
    'authentication.k8s.io/v1/SelfSubjectReview' => 'selfsubjectreviews',
    'authentication.k8s.io/v1/TokenReview'       => 'tokenreviews',

    # authorization.k8s.io
    'authorization.k8s.io/v1/LocalSubjectAccessReview' => 'localsubjectaccessreviews',
    'authorization.k8s.io/v1/SelfSubjectAccessReview'  => 'selfsubjectaccessreviews',
    'authorization.k8s.io/v1/SelfSubjectRulesReview'   => 'selfsubjectrulesreviews',
    'authorization.k8s.io/v1/SubjectAccessReview'      => 'subjectaccessreviews',

    # autoscaling
    'autoscaling/v1/HorizontalPodAutoscaler' => 'horizontalpodautoscalers',
    'autoscaling/v2/HorizontalPodAutoscaler' => 'horizontalpodautoscalers',

    # batch
    'batch/v1/CronJob' => 'cronjobs',
    'batch/v1/Job'     => 'jobs',

    # certificates.k8s.io
    'certificates.k8s.io/v1/CertificateSigningRequest'  => 'certificatesigningrequests',
    'certificates.k8s.io/v1/ClusterTrustBundle'         => 'clustertrustbundles',
    'certificates.k8s.io/v1/PodCertificateRequest'      => 'podcertificaterequests',
    'certificates.k8s.io/v1beta1/ClusterTrustBundle'    => 'clustertrustbundles',
    'certificates.k8s.io/v1beta1/PodCertificateRequest' => 'podcertificaterequests',

    # coordination.k8s.io
    'coordination.k8s.io/v1/Lease'                => 'leases',
    'coordination.k8s.io/v1alpha2/LeaseCandidate' => 'leasecandidates',
    'coordination.k8s.io/v1beta1/LeaseCandidate'  => 'leasecandidates',

    # discovery.k8s.io
    'discovery.k8s.io/v1/EndpointSlice' => 'endpointslices',

    # events.k8s.io
    'events.k8s.io/v1/Event' => 'events',

    # flowcontrol.apiserver.k8s.io
    'flowcontrol.apiserver.k8s.io/v1/FlowSchema'                 => 'flowschemas',
    'flowcontrol.apiserver.k8s.io/v1/PriorityLevelConfiguration' => 'prioritylevelconfigurations',

    # internal.apiserver.k8s.io
    'internal.apiserver.k8s.io/v1alpha1/StorageVersion' => 'storageversions',

    # lifecycle.k8s.io
    'lifecycle.k8s.io/v1alpha1/Eviction'        => 'evictions',
    'lifecycle.k8s.io/v1alpha1/EvictionRequest' => 'evictionrequests',

    # networking.k8s.io
    'networking.k8s.io/v1/IPAddress'     => 'ipaddresses',
    'networking.k8s.io/v1/Ingress'       => 'ingresses',
    'networking.k8s.io/v1/IngressClass'  => 'ingressclasses',
    'networking.k8s.io/v1/NetworkPolicy' => 'networkpolicies',
    'networking.k8s.io/v1/ServiceCIDR'   => 'servicecidrs',

    # node.k8s.io
    'node.k8s.io/v1/RuntimeClass' => 'runtimeclasses',

    # policy
    'policy/v1/PodDisruptionBudget' => 'poddisruptionbudgets',

    # rbac.authorization.k8s.io
    'rbac.authorization.k8s.io/v1/ClusterRole'        => 'clusterroles',
    'rbac.authorization.k8s.io/v1/ClusterRoleBinding' => 'clusterrolebindings',
    'rbac.authorization.k8s.io/v1/Role'               => 'roles',
    'rbac.authorization.k8s.io/v1/RoleBinding'        => 'rolebindings',

    # resource.k8s.io
    'resource.k8s.io/v1/DeviceClass'                     => 'deviceclasses',
    'resource.k8s.io/v1/DeviceTaintRule'                 => 'devicetaintrules',
    'resource.k8s.io/v1/ResourceClaim'                   => 'resourceclaims',
    'resource.k8s.io/v1/ResourceClaimTemplate'           => 'resourceclaimtemplates',
    'resource.k8s.io/v1/ResourceSlice'                   => 'resourceslices',
    'resource.k8s.io/v1alpha3/DeviceTaintRule'           => 'devicetaintrules',
    'resource.k8s.io/v1alpha3/ResourcePoolStatusRequest' => 'resourcepoolstatusrequests',
    'resource.k8s.io/v1beta1/DeviceClass'                => 'deviceclasses',
    'resource.k8s.io/v1beta1/ResourceClaim'              => 'resourceclaims',
    'resource.k8s.io/v1beta1/ResourceClaimTemplate'      => 'resourceclaimtemplates',
    'resource.k8s.io/v1beta1/ResourceSlice'              => 'resourceslices',
    'resource.k8s.io/v1beta2/DeviceClass'                => 'deviceclasses',
    'resource.k8s.io/v1beta2/DeviceTaintRule'            => 'devicetaintrules',
    'resource.k8s.io/v1beta2/ResourceClaim'              => 'resourceclaims',
    'resource.k8s.io/v1beta2/ResourceClaimTemplate'      => 'resourceclaimtemplates',
    'resource.k8s.io/v1beta2/ResourceSlice'              => 'resourceslices',

    # scheduling.k8s.io
    'scheduling.k8s.io/v1/PriorityClass'           => 'priorityclasses',
    'scheduling.k8s.io/v1alpha3/CompositePodGroup' => 'compositepodgroups',
    'scheduling.k8s.io/v1alpha3/PodGroup'          => 'podgroups',
    'scheduling.k8s.io/v1alpha3/Workload'          => 'workloads',
    'scheduling.k8s.io/v1beta1/PodGroup'           => 'podgroups',
    'scheduling.k8s.io/v1beta1/Workload'           => 'workloads',

    # storage.k8s.io
    'storage.k8s.io/v1/CSIDriver'             => 'csidrivers',
    'storage.k8s.io/v1/CSINode'               => 'csinodes',
    'storage.k8s.io/v1/CSIStorageCapacity'    => 'csistoragecapacities',
    'storage.k8s.io/v1/StorageClass'          => 'storageclasses',
    'storage.k8s.io/v1/VolumeAttachment'      => 'volumeattachments',
    'storage.k8s.io/v1/VolumeAttributesClass' => 'volumeattributesclasses',

    # storagemigration.k8s.io
    'storagemigration.k8s.io/v1/StorageVersionMigration'      => 'storageversionmigrations',
    'storagemigration.k8s.io/v1beta1/StorageVersionMigration' => 'storageversionmigrations',
);
# --- END GENERATED resource plural table ---

# --- BEGIN GENERATED group resource plural table (v1.37.0) ---
# Regenerate with: maint/spec-resource-plural-gen.pl --spec spec/v1.37.0.json
my %RESOURCE_PLURAL_BY_GROUP = (
    # core
    '|Binding'               => 'bindings',
    '|ComponentStatus'       => 'componentstatuses',
    '|ConfigMap'             => 'configmaps',
    '|Endpoints'             => 'endpoints',
    '|Event'                 => 'events',
    '|LimitRange'            => 'limitranges',
    '|Namespace'             => 'namespaces',
    '|Node'                  => 'nodes',
    '|PersistentVolume'      => 'persistentvolumes',
    '|PersistentVolumeClaim' => 'persistentvolumeclaims',
    '|Pod'                   => 'pods',
    '|PodTemplate'           => 'podtemplates',
    '|ReplicationController' => 'replicationcontrollers',
    '|ResourceQuota'         => 'resourcequotas',
    '|Secret'                => 'secrets',
    '|Service'               => 'services',
    '|ServiceAccount'        => 'serviceaccounts',

    # admissionregistration.k8s.io
    'admissionregistration.k8s.io|MutatingAdmissionPolicy'          => 'mutatingadmissionpolicies',
    'admissionregistration.k8s.io|MutatingAdmissionPolicyBinding'   => 'mutatingadmissionpolicybindings',
    'admissionregistration.k8s.io|MutatingWebhookConfiguration'     => 'mutatingwebhookconfigurations',
    'admissionregistration.k8s.io|ValidatingAdmissionPolicy'        => 'validatingadmissionpolicies',
    'admissionregistration.k8s.io|ValidatingAdmissionPolicyBinding' => 'validatingadmissionpolicybindings',
    'admissionregistration.k8s.io|ValidatingWebhookConfiguration'   => 'validatingwebhookconfigurations',

    # apiextensions.k8s.io
    'apiextensions.k8s.io|CustomResourceDefinition' => 'customresourcedefinitions',

    # apiregistration.k8s.io
    'apiregistration.k8s.io|APIService' => 'apiservices',

    # apps
    'apps|ControllerRevision' => 'controllerrevisions',
    'apps|DaemonSet'          => 'daemonsets',
    'apps|Deployment'         => 'deployments',
    'apps|ReplicaSet'         => 'replicasets',
    'apps|StatefulSet'        => 'statefulsets',

    # authentication.k8s.io
    'authentication.k8s.io|SelfSubjectReview' => 'selfsubjectreviews',
    'authentication.k8s.io|TokenReview'       => 'tokenreviews',

    # authorization.k8s.io
    'authorization.k8s.io|LocalSubjectAccessReview' => 'localsubjectaccessreviews',
    'authorization.k8s.io|SelfSubjectAccessReview'  => 'selfsubjectaccessreviews',
    'authorization.k8s.io|SelfSubjectRulesReview'   => 'selfsubjectrulesreviews',
    'authorization.k8s.io|SubjectAccessReview'      => 'subjectaccessreviews',

    # autoscaling
    'autoscaling|HorizontalPodAutoscaler' => 'horizontalpodautoscalers',

    # batch
    'batch|CronJob' => 'cronjobs',
    'batch|Job'     => 'jobs',

    # certificates.k8s.io
    'certificates.k8s.io|CertificateSigningRequest' => 'certificatesigningrequests',
    'certificates.k8s.io|ClusterTrustBundle'        => 'clustertrustbundles',
    'certificates.k8s.io|PodCertificateRequest'     => 'podcertificaterequests',

    # coordination.k8s.io
    'coordination.k8s.io|Lease'          => 'leases',
    'coordination.k8s.io|LeaseCandidate' => 'leasecandidates',

    # discovery.k8s.io
    'discovery.k8s.io|EndpointSlice' => 'endpointslices',

    # events.k8s.io
    'events.k8s.io|Event' => 'events',

    # flowcontrol.apiserver.k8s.io
    'flowcontrol.apiserver.k8s.io|FlowSchema'                 => 'flowschemas',
    'flowcontrol.apiserver.k8s.io|PriorityLevelConfiguration' => 'prioritylevelconfigurations',

    # internal.apiserver.k8s.io
    'internal.apiserver.k8s.io|StorageVersion' => 'storageversions',

    # lifecycle.k8s.io
    'lifecycle.k8s.io|Eviction'        => 'evictions',
    'lifecycle.k8s.io|EvictionRequest' => 'evictionrequests',

    # networking.k8s.io
    'networking.k8s.io|IPAddress'     => 'ipaddresses',
    'networking.k8s.io|Ingress'       => 'ingresses',
    'networking.k8s.io|IngressClass'  => 'ingressclasses',
    'networking.k8s.io|NetworkPolicy' => 'networkpolicies',
    'networking.k8s.io|ServiceCIDR'   => 'servicecidrs',

    # node.k8s.io
    'node.k8s.io|RuntimeClass' => 'runtimeclasses',

    # policy
    'policy|PodDisruptionBudget' => 'poddisruptionbudgets',

    # rbac.authorization.k8s.io
    'rbac.authorization.k8s.io|ClusterRole'        => 'clusterroles',
    'rbac.authorization.k8s.io|ClusterRoleBinding' => 'clusterrolebindings',
    'rbac.authorization.k8s.io|Role'               => 'roles',
    'rbac.authorization.k8s.io|RoleBinding'        => 'rolebindings',

    # resource.k8s.io
    'resource.k8s.io|DeviceClass'               => 'deviceclasses',
    'resource.k8s.io|DeviceTaintRule'           => 'devicetaintrules',
    'resource.k8s.io|ResourceClaim'             => 'resourceclaims',
    'resource.k8s.io|ResourceClaimTemplate'     => 'resourceclaimtemplates',
    'resource.k8s.io|ResourcePoolStatusRequest' => 'resourcepoolstatusrequests',
    'resource.k8s.io|ResourceSlice'             => 'resourceslices',

    # scheduling.k8s.io
    'scheduling.k8s.io|CompositePodGroup' => 'compositepodgroups',
    'scheduling.k8s.io|PodGroup'          => 'podgroups',
    'scheduling.k8s.io|PriorityClass'     => 'priorityclasses',
    'scheduling.k8s.io|Workload'          => 'workloads',

    # storage.k8s.io
    'storage.k8s.io|CSIDriver'             => 'csidrivers',
    'storage.k8s.io|CSINode'               => 'csinodes',
    'storage.k8s.io|CSIStorageCapacity'    => 'csistoragecapacities',
    'storage.k8s.io|StorageClass'          => 'storageclasses',
    'storage.k8s.io|VolumeAttachment'      => 'volumeattachments',
    'storage.k8s.io|VolumeAttributesClass' => 'volumeattributesclasses',

    # storagemigration.k8s.io
    'storagemigration.k8s.io|StorageVersionMigration' => 'storageversionmigrations',
);
# --- END GENERATED group resource plural table ---

# Walk @ISA depth-first, left to right (same shape as
# IO::K8s::Role::Resource::_merged_attr_info) so a consumer subclass
# registered via class_namespaces derives the apiVersion from the first
# ancestor that is a known namespace.
sub _api_version_from_isa {
    my ($class) = @_;
    no strict 'refs';
    for my $parent (@{"${class}::ISA"}) {
        my $version = _api_version_from_class($parent);
        return $version if defined $version;
        $version = _api_version_from_isa($parent);
        return $version if defined $version;
    }
    return undef;
}

=method api_version

Returns the Kubernetes API version derived from the class name. For a
consumer subclass registered via L<IO::K8s/class_namespaces>, the version is
derived from the first ancestor in a known namespace.

    $pod->api_version;  # "v1"
    $deployment->api_version;  # "apps/v1"

Derived identity, not a writable field: passing an argument croaks
rather than silently rebinding (k67). CRD classes installed via
L<IO::K8s::APIObject/api_version> install a fixed-value method with the
same contract -- see there for the precise error message.

=cut

sub api_version {
    my ($self) = @_;
    croak __PACKAGE__.'->api_version is derived from the class name and cannot be set'
        if @_ > 1;
    my $class = ref($self) || $self;

    my $version = _api_version_from_class($class);
    return $version if defined $version;

    return _api_version_from_isa($class);
}

# Look the plural up under the same "$api_version/$Kind" key the generated
# table is written with, then fall back to "$group|$Kind". Both halves come
# from the class name, so this is only ever a hit for a class in one of the
# known namespaces -- a CRD class with an explicitly installed api_version()
# never reaches here at all (its own resource_plural, if it declared one,
# shadows this role's).
#
# The group is recovered from the api_version the same way the generator
# folded it in: everything before the last '/', and the empty string for a
# core-group version like "v1". A miss in both tiers is undef, never a
# guess.
sub _resource_plural_from_class {
    my ($class) = @_;

    my $version = _api_version_from_class($class);
    return undef unless defined $version;

    my ($kind) = $class =~ /::(\w+)\z/;
    return undef unless defined $kind;

    my $plural = $RESOURCE_PLURAL{"$version/$kind"};
    return $plural if defined $plural;

    my ($group) = $version =~ m{\A(.*)/[^/]+\z};
    $group = '' unless defined $group;

    return $RESOURCE_PLURAL_BY_GROUP{"$group|$kind"};
}

# Same depth-first, left-to-right @ISA walk as _api_version_from_isa, for
# the same reason: a consumer subclass registered via class_namespaces
# ('My::K8s::Api::Core::V1::Pod' -> IO::K8s::Api::Core::V1::Pod) inherits
# the plural from the first ancestor in a known namespace.
sub _resource_plural_from_isa {
    my ($class) = @_;
    no strict 'refs';
    for my $parent (@{"${class}::ISA"}) {
        my $plural = _resource_plural_from_class($parent);
        return $plural if defined $plural;
        $plural = _resource_plural_from_isa($parent);
        return $plural if defined $plural;
    }
    return undef;
}

=method kind

Returns the Kubernetes kind derived from the class name: the last C<::>
segment, or the whole name for a single-segment class such as a CRD
registered as C<+Widget>.

    $pod->kind;  # "Pod"
    $deployment->kind;  # "Deployment"

Derived identity, not a writable field: passing an argument croaks
rather than silently rebinding (k67). Auto-generated CRD classes
install a fixed-value method with the same contract -- see
L<IO::K8s::AutoGen> for the precise error message.

=cut

sub kind {
    my ($self) = @_;
    croak __PACKAGE__.'->kind is derived from the class name and cannot be set'
        if @_ > 1;
    my $class = ref($self) || $self;

    if ($class =~ /::(\w+)$/) {
        return $1;
    }

    # No '::' at all: a CRD registered as a single-segment top-level package,
    # reached as '+Widget' or through a resource_map value of '+Widget'. That
    # is a supported shape -- '+Name' is the documented route to a
    # single-segment class of your own, and k35 is what made those names
    # reliably reachable -- so the whole name is the last segment. Without
    # this the class is reachable but TO_JSON emits no kind: at all, which the
    # API server rejects (k38).
    if ($class =~ /\A(\w+)\z/) {
        return $1;
    }

    return undef;
}

=method resource_plural

Returns the plural resource name Kubernetes addresses this Kind by in RBAC
C<resources:> rules, and in REST paths for a Kind on an API track upstream
still serves, or C<undef> when there is none.

    $pod->resource_plural;            # "pods"
    $endpoints->resource_plural;      # "endpoints"
    $network_policy->resource_plural; # "networkpolicies"
    $ingress->resource_plural;        # "ingresses"

For built-in Kinds the value comes from two tables generated from the
upstream OpenAPI spec's REST paths. The exact API version and kind are
looked up first, so C<Event> in the core group and C<Event> in
C<events.k8s.io> resolve independently. A Kind on an API track upstream no
longer serves then falls back to its API group and kind: the plural is a
property of the GroupResource, which is what RBAC C<apiGroups>/C<resources>
rules address, and the fallback is only generated where every version of
that group agrees on the plural. It is still group and kind, never a bare
kind, so the two C<Event>s stay distinct on that path too.

That fallback value is right for RBAC, and no other plural would serve a
Kind on such a track better -- do not "fix" it. It is not a promise that
the REST path built from the plural and the class's own C<api_version>
resolves: upstream has stopped serving that track entirely, so the path
404s against a current cluster regardless of what the plural is.

A consumer subclass registered via L<IO::K8s/class_namespaces> inherits the
plural from its first ancestor in a known namespace, the same way
C<api_version> does.

C<undef> means "not a top-level resource, or not known" and should never be
turned into a guess: C<Eviction>, C<Scale> and C<TokenRequest> are
subresources (C<pods/eviction>, C<deployments/scale>,
C<serviceaccounts/token>) and have no plural of their own, and the embedded
C<PodTemplateSpec>-style types never appear as a C<kind:> on the wire at
all.

CRD classes declare their own, which always wins over the built-in table:

    use IO::K8s::APIObject
        api_version     => 'homelab.example.com/v1',
        resource_plural => 'staticwebsites';

Derived identity, not a writable field: passing an argument croaks
rather than silently rebinding (k70). CRD classes installed via
L<IO::K8s::APIObject/resource_plural> install a fixed-value method with
the same contract -- see there for the precise error message.

=cut

sub resource_plural {
    my ($self) = @_;
    croak __PACKAGE__.'->resource_plural is derived from the class name and cannot be set'
        if @_ > 1;
    my $class = ref($self) || $self;

    my $plural = _resource_plural_from_class($class);
    return $plural if defined $plural;

    return _resource_plural_from_isa($class);
}

sub _is_resource { 1 }

=method to_crd

    my $crd = $pod->to_crd;
    my $crd = IO::K8s::Api::Core::V1::Pod->to_crd;

The C<CustomResourceDefinition> this class's own attribute registry
describes (D9) -- the exact inverse of L<IO::K8s::AutoGen>'s
schema-to-DSL mapping. See L<IO::K8s::CRD/crd_for_class>, which this
delegates to.

=cut

sub to_crd {
    my ($self) = @_;
    require IO::K8s::CRD;
    return IO::K8s::CRD::crd_for_class(ref($self) || $self);
}

sub to_yaml {
    my ($self) = @_;
    require YAML::PP;
    my $yp = YAML::PP->new(schema => [qw/JSON/], boolean => 'JSON::PP');
    return $yp->dump_string($self->TO_JSON);
}

=method to_yaml

    my $yaml = $pod->to_yaml;

Serialize the object to YAML format suitable for C<kubectl apply -f>.

=cut

sub save {
    my ($self, $file) = @_;
    open my $fh, '>', $file or die "Cannot write to $file: $!";
    print $fh $self->to_yaml;
    close $fh;
    return $self;
}

=method save

    $pod->save('pod.yaml');

Save the object to a YAML file. Returns the object for chaining.

=cut

# ============================================================
# Label & annotation convenience methods
# ============================================================

sub _ensure_metadata {
    my ($self) = @_;
    unless ($self->metadata) {
        require IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta;
        $self->metadata(IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta->new);
    }
    return $self->metadata;
}

=method add_label

    $obj->add_label(app => 'web');

Add a single label. Returns C<$self> for chaining.

=cut

sub add_label {
    my ($self, $key, $value) = @_;
    my $meta = $self->_ensure_metadata;
    my $labels = $meta->labels // {};
    $labels->{$key} = $value;
    $meta->labels($labels);
    return $self;
}

=method add_labels

    $obj->add_labels(app => 'web', tier => 'frontend');

Add multiple labels at once. Returns C<$self> for chaining.

=cut

sub add_labels {
    my ($self, %pairs) = @_;
    my $meta = $self->_ensure_metadata;
    my $labels = $meta->labels // {};
    @{$labels}{keys %pairs} = values %pairs;
    $meta->labels($labels);
    return $self;
}

=method label

    my $val = $obj->label('app');  # => 'web'

Get the value of a single label, or C<undef> if missing.

=cut

sub label {
    my ($self, $key) = @_;
    my $labels = $self->metadata ? $self->metadata->labels : undef;
    return defined $labels ? $labels->{$key} : undef;
}

=method has_label

    $obj->has_label('app');  # => 1

Returns true if the label key exists.

=cut

sub has_label {
    my ($self, $key) = @_;
    my $labels = $self->metadata ? $self->metadata->labels : undef;
    return defined $labels && exists $labels->{$key} ? 1 : 0;
}

=method remove_label

    $obj->remove_label('tier');

Remove a label by key. Returns C<$self> for chaining.

=cut

sub remove_label {
    my ($self, $key) = @_;
    if ($self->metadata && $self->metadata->labels) {
        delete $self->metadata->labels->{$key};
    }
    return $self;
}

=method match_labels

    $obj->match_labels(app => 'web', tier => 'frontend');  # => Bool

Returns true if all given key/value pairs match the object's labels.

=cut

sub match_labels {
    my ($self, %expected) = @_;
    my $labels = $self->metadata ? $self->metadata->labels : undef;
    return 0 unless defined $labels;
    for my $key (keys %expected) {
        return 0 unless exists $labels->{$key} && $labels->{$key} eq $expected{$key};
    }
    return 1;
}

=method add_annotation

    $obj->add_annotation('prometheus.io/scrape' => 'true');

Add a single annotation. Returns C<$self> for chaining.

=cut

sub add_annotation {
    my ($self, $key, $value) = @_;
    my $meta = $self->_ensure_metadata;
    my $annotations = $meta->annotations // {};
    $annotations->{$key} = $value;
    $meta->annotations($annotations);
    return $self;
}

=method annotation

    my $val = $obj->annotation('prometheus.io/scrape');

Get the value of a single annotation, or C<undef> if missing.

=cut

sub annotation {
    my ($self, $key) = @_;
    my $annotations = $self->metadata ? $self->metadata->annotations : undef;
    return defined $annotations ? $annotations->{$key} : undef;
}

=method has_annotation

    $obj->has_annotation('prometheus.io/scrape');  # => 1

Returns true if the annotation key exists.

=cut

sub has_annotation {
    my ($self, $key) = @_;
    my $annotations = $self->metadata ? $self->metadata->annotations : undef;
    return defined $annotations && exists $annotations->{$key} ? 1 : 0;
}

=method remove_annotation

    $obj->remove_annotation('prometheus.io/scrape');

Remove an annotation by key. Returns C<$self> for chaining.

=cut

sub remove_annotation {
    my ($self, $key) = @_;
    if ($self->metadata && $self->metadata->annotations) {
        delete $self->metadata->annotations->{$key};
    }
    return $self;
}

# ============================================================
# Status condition convenience methods
# ============================================================

sub _extract_conditions {
    my ($self) = @_;
    return [] unless $self->can('status') && defined $self->status;
    my $status = $self->status;

    # Typed status object with conditions accessor
    if (blessed($status) && $status->can('conditions')) {
        my $conds = $status->conditions;
        return $conds if ref $conds eq 'ARRAY';
        return [];
    }

    # Opaque hashref (CRDs)
    if (ref $status eq 'HASH' && ref $status->{conditions} eq 'ARRAY') {
        return $status->{conditions};
    }

    return [];
}

sub _condition_field {
    my ($cond, $field) = @_;
    if (blessed($cond) && $cond->can($field)) {
        return $cond->$field;
    }
    if (ref $cond eq 'HASH') {
        return $cond->{$field};
    }
    return undef;
}

=method conditions

    my $conds = $obj->conditions;  # => ArrayRef

Returns all status conditions as an arrayref.

=cut

sub conditions {
    my ($self) = @_;
    return $self->_extract_conditions;
}

=method get_condition

    my $cond = $obj->get_condition('Ready');  # => hashref/object or undef

Get a single condition by type name.

=cut

sub get_condition {
    my ($self, $type) = @_;
    for my $cond (@{ $self->_extract_conditions }) {
        my $ctype = _condition_field($cond, 'type');
        return $cond if defined $ctype && $ctype eq $type;
    }
    return undef;
}

=method is_condition_true

    $obj->is_condition_true('Available');  # => Bool

Returns true if the named condition has C<status = "True">.

=cut

sub is_condition_true {
    my ($self, $type) = @_;
    my $cond = $self->get_condition($type);
    return 0 unless defined $cond;
    my $status = _condition_field($cond, 'status');
    return defined $status && $status eq 'True' ? 1 : 0;
}

=method is_ready

    $obj->is_ready;  # => Bool

Returns true if the C<Ready> or C<Available> condition is true.

=cut

sub is_ready {
    my ($self) = @_;
    return 1 if $self->is_condition_true('Ready');
    return 1 if $self->is_condition_true('Available');
    return 0;
}

=method condition_message

    my $msg = $obj->condition_message('Ready');

Returns the message string for the named condition, or C<undef>.

=cut

sub condition_message {
    my ($self, $type) = @_;
    my $cond = $self->get_condition($type);
    return undef unless defined $cond;
    return _condition_field($cond, 'message');
}

# ============================================================
# Owner reference convenience methods
# ============================================================

=method set_owner

    $pod->set_owner($deployment);
    $pod->set_owner($configmap, controller => 0);

Add an ownerReference pointing to another API object.
Returns C<$self> for chaining.

The owner must carry a C<metadata.uid> — the uid is assigned by the API
server, so only an object read back from the cluster can be referenced.
A locally built owner (no metadata, or no uid) makes set_owner die,
naming the owner.

C<< controller => 0|1 >> (default 1) marks the reference as the managing
controller. Kubernetes allows at most one ownerReference with
C<controller: true> per object: adding a second one dies, naming the
existing controller reference — pass C<< controller => 0 >> for
additional, non-controlling owners.

Setting the same owner twice (same uid) is an idempotent no-op, even
when the repeated call asks for C<controller> — the existing reference
is left untouched.

C<blockOwnerDeletion> is never set; upstream defaults it to false.

=cut

sub set_owner {
    my ($self, $owner, %opts) = @_;
    require IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::OwnerReference;

    my $controller = exists $opts{controller} ? ($opts{controller} ? 1 : 0) : 1;

    my $owner_kind = $owner->kind;
    my $owner_meta = $owner->metadata;
    my $owner_name = $owner_meta ? $owner_meta->name : undef;
    my $owner_desc = defined $owner_name ? "$owner_kind/$owner_name" : $owner_kind;

    my $owner_uid = $owner_meta ? $owner_meta->uid : undef;
    if (!defined $owner_uid || $owner_uid eq '') {
        die "set_owner: cannot reference $owner_desc: owner has no uid;"
          . " the uid is assigned by the API server, so only an object"
          . " read back from the cluster can be referenced\n";
    }

    my $meta = $self->_ensure_metadata;
    my $refs = $meta->ownerReferences // [];

    my $existing_controller;
    for my $ref (@$refs) {
        my ($ruid, $rctl, $rkind, $rname);
        if (blessed($ref) && $ref->can('uid')) {
            ($ruid, $rctl, $rkind, $rname)
                = ($ref->uid, $ref->controller, $ref->kind, $ref->name);
        } elsif (ref $ref eq 'HASH') {
            ($ruid, $rctl, $rkind, $rname) = @{$ref}{qw(uid controller kind name)};
        }

        # Same owner already referenced: idempotent no-op (checked before
        # the controller conflict -- the reference exists, nothing changes).
        return $self if defined $ruid && $ruid eq $owner_uid;

        $existing_controller //= { kind => $rkind, name => $rname } if $rctl;
    }

    if ($controller && $existing_controller) {
        my $have = join '/', grep { defined && length }
            $existing_controller->{kind}, $existing_controller->{name};
        $have = 'an existing ownerReference' unless length $have;
        die "set_owner: cannot add $owner_desc as controller: $have is"
          . " already the controller reference; Kubernetes allows at most"
          . " one, pass controller => 0 to add a non-controlling owner\n";
    }

    my $ref = IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::OwnerReference->new(
        apiVersion => $owner->api_version,
        kind       => $owner_kind,
        name       => $owner_name,
        uid        => $owner_uid,
        ($controller ? (controller => 1) : ()),
    );

    $meta->ownerReferences([@$refs, $ref]);
    return $self;
}

=method is_owned_by

    $pod->is_owned_by($deployment);  # => Bool

Returns true if this object has an ownerReference matching the given object.

=cut

sub is_owned_by {
    my ($self, $owner) = @_;
    my $refs = $self->owner_refs;
    my $owner_uid  = $owner->metadata ? $owner->metadata->uid  : undef;
    my $owner_name = $owner->metadata ? $owner->metadata->name : undef;
    my $owner_kind = $owner->kind;

    for my $ref (@$refs) {
        my ($rname, $ruid, $rkind);
        if (blessed($ref) && $ref->can('name')) {
            $rname = $ref->name;
            $ruid  = $ref->uid;
            $rkind = $ref->kind;
        } elsif (ref $ref eq 'HASH') {
            $rname = $ref->{name};
            $ruid  = $ref->{uid};
            $rkind = $ref->{kind};
        }

        # Match by UID if both have it, otherwise by name+kind
        if (defined $owner_uid && $owner_uid ne '' && defined $ruid && $ruid ne '') {
            return 1 if $ruid eq $owner_uid;
        } elsif (defined $owner_name && defined $rname && defined $owner_kind && defined $rkind) {
            return 1 if $rname eq $owner_name && $rkind eq $owner_kind;
        }
    }
    return 0;
}

=method owner_refs

    my $refs = $obj->owner_refs;  # => ArrayRef

Returns the ownerReferences array, or an empty arrayref.

=cut

sub owner_refs {
    my ($self) = @_;
    return [] unless $self->metadata;
    return $self->metadata->ownerReferences // [];
}

1;
