package IO::K8s::Role::Loadbalanced;
# ABSTRACT: Role for traffic distribution (weighted backends, mirroring)
our $VERSION = '1.001';
use Moo::Role;

sub set_weighted {
    my ($self, $name, $weight) = @_;
    my $spec = $self->spec // {};
    my $weighted = $spec->{weighted} //= { services => [] };
    my $services = $weighted->{services};

    # Update existing or add new
    my $found = 0;
    for my $svc (@$services) {
        if ($svc->{name} eq $name) {
            $svc->{weight} = $weight;
            $found = 1;
            last;
        }
    }
    push @$services, { name => $name, weight => $weight } unless $found;
    $self->spec($spec);
    return $self;
}

sub mirror_to {
    my ($self, $name, %opts) = @_;
    my $spec = $self->spec // {};
    my $mirroring = $spec->{mirroring} //= {};
    my $mirrors = $mirroring->{mirrors} //= [];
    push @$mirrors, {
        name => $name,
        $opts{percent} ? (percent => $opts{percent}) : (),
    };
    $self->spec($spec);
    return $self;
}

1;
