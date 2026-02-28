package IO::K8s::Role::HelmManaged;
# ABSTRACT: Role for K3s Helm chart management
our $VERSION = '1.004';
use Moo::Role;

sub from_repo {
    my ($self, $repo_url, $chart_name) = @_;
    my $spec = $self->spec // {};
    $spec->{repo}  = $repo_url;
    $spec->{chart} = $chart_name;
    $self->spec($spec);
    return $self;
}

sub set_version {
    my ($self, $version) = @_;
    my $spec = $self->spec // {};
    $spec->{version} = $version;
    $self->spec($spec);
    return $self;
}

sub set_values {
    my ($self, %values) = @_;
    my $spec = $self->spec // {};
    my $existing = $spec->{set} // {};
    @{$existing}{keys %values} = values %values;
    $spec->{set} = $existing;
    $self->spec($spec);
    return $self;
}

sub set_values_yaml {
    my ($self, $yaml_str) = @_;
    my $spec = $self->spec // {};
    $spec->{valuesContent} = $yaml_str;
    $self->spec($spec);
    return $self;
}

1;
