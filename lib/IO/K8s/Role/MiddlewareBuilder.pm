package IO::K8s::Role::MiddlewareBuilder;
# ABSTRACT: Role for building Traefik middleware configuration
our $VERSION = '1.002';
use Moo::Role;

sub rate_limit {
    my ($self, %opts) = @_;
    my $spec = $self->spec // {};
    $spec->{rateLimit} = {
        $opts{average} ? (average => $opts{average}) : (),
        $opts{burst}   ? (burst   => $opts{burst})   : (),
        $opts{period}  ? (period  => $opts{period})  : (),
    };
    $self->spec($spec);
    return $self;
}

sub basic_auth {
    my ($self, %opts) = @_;
    my $spec = $self->spec // {};
    $spec->{basicAuth} = {
        $opts{secret} ? (secret => $opts{secret}) : (),
        $opts{realm}  ? (realm  => $opts{realm})  : (),
    };
    $self->spec($spec);
    return $self;
}

sub strip_prefix {
    my ($self, @prefixes) = @_;
    my $spec = $self->spec // {};
    $spec->{stripPrefix} = {
        prefixes => \@prefixes,
    };
    $self->spec($spec);
    return $self;
}

sub redirect_https {
    my ($self) = @_;
    my $spec = $self->spec // {};
    $spec->{redirectScheme} = {
        scheme    => 'https',
        permanent => 1,
    };
    $self->spec($spec);
    return $self;
}

sub add_request_header {
    my ($self, $key, $value) = @_;
    my $spec = $self->spec // {};
    my $headers = $spec->{headers} //= {};
    my $custom = $headers->{customRequestHeaders} //= {};
    $custom->{$key} = $value;
    $self->spec($spec);
    return $self;
}

sub add_response_header {
    my ($self, $key, $value) = @_;
    my $spec = $self->spec // {};
    my $headers = $spec->{headers} //= {};
    my $custom = $headers->{customResponseHeaders} //= {};
    $custom->{$key} = $value;
    $self->spec($spec);
    return $self;
}

1;
