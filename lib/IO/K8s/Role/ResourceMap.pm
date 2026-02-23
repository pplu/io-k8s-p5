package IO::K8s::Role::ResourceMap;
# ABSTRACT: Role for packages that provide a Kubernetes resource map
our $VERSION = '1.003';
use Moo::Role;

requires 'resource_map';

1;

__END__

=encoding UTF-8

=head1 NAME

IO::K8s::Role::ResourceMap - Role for packages that provide a Kubernetes resource map

=head1 SYNOPSIS

    package IO::K8s::Cilium;
    use Moo;
    with 'IO::K8s::Role::ResourceMap';

    sub resource_map {
        return {
            CiliumNetworkPolicy => '+IO::K8s::Cilium::V2::CiliumNetworkPolicy',
            NetworkPolicy       => '+IO::K8s::Cilium::V2::NetworkPolicy',
        };
    }

    1;

=head1 DESCRIPTION

This role marks packages that provide a Kubernetes resource map, mapping
short kind names to class paths. Packages consuming this role can be passed
to L<IO::K8s/add> or the L<IO::K8s/with> constructor parameter to merge
their resources into an IO::K8s instance.

The C<resource_map> method must return a hashref mapping kind names (like
C<CiliumNetworkPolicy>) to class paths. Class paths without a C<+> prefix
are relative to C<IO::K8s::>. Class paths with a C<+> prefix are used as-is.

=head1 REQUIRED METHODS

=head2 resource_map

Must return a HashRef mapping kind names to class paths.

=head1 SEE ALSO

L<IO::K8s>, L<IO::K8s/add>

=cut
