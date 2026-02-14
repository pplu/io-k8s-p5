package IO::K8s::Role::APIObject;
# ABSTRACT: Role for top-level Kubernetes API objects
our $VERSION = '1.001';
use Moo::Role;
use Types::Standard qw( InstanceOf Maybe );
use Scalar::Util qw(blessed);

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
);

# Derive apiVersion from class name
# IO::K8s::Api::Core::V1::Pod -> v1
# IO::K8s::Api::Apps::V1::Deployment -> apps/v1
# IO::K8s::Api::Rbac::V1::Role -> rbac.authorization.k8s.io/v1
sub api_version {
    my ($self) = @_;
    my $class = ref($self) || $self;

    if ($class =~ /^IO::K8s::Api::(\w+)::(\w+)::/) {
        my ($group, $version) = ($1, $2);
        $version = lc($version);
        return $version if $group eq 'Core';
        my $group_lc = lc($group);
        return ($API_GROUP_MAP{$group_lc} // $group_lc) . '/' . $version;
    }
    return undef;
}

=method api_version

Returns the Kubernetes API version derived from the class name.

    $pod->api_version;  # "v1"
    $deployment->api_version;  # "apps/v1"

=cut

sub kind {
    my ($self) = @_;
    my $class = ref($self) || $self;

    if ($class =~ /::(\w+)$/) {
        return $1;
    }
    return undef;
}

=method kind

Returns the Kubernetes kind derived from the class name.

    $pod->kind;  # "Pod"
    $deployment->kind;  # "Deployment"

=cut

sub resource_plural { undef }

=method resource_plural

Returns the plural resource name for URL building, or C<undef> to use
automatic pluralization. Override this in CRD classes where the plural
name is not simply the lowercased kind with an "s" appended:

    sub resource_plural { 'staticwebsites' }

=cut

sub _is_resource { 1 }

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

Add an ownerReference pointing to another API object.
Returns C<$self> for chaining.

=cut

sub set_owner {
    my ($self, $owner) = @_;
    require IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::OwnerReference;
    my $meta = $self->_ensure_metadata;
    my $refs = $meta->ownerReferences // [];

    my $ref = IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::OwnerReference->new(
        apiVersion => $owner->api_version,
        kind       => $owner->kind,
        name       => $owner->metadata->name,
        uid        => $owner->metadata->uid // '',
        controller => 1,
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
