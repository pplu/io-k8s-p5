package IO::K8s::Role::Namespaced;
our $VERSION = '1.005';
# ABSTRACT: Role for Kubernetes resources that live in a namespace
use Moo::Role;

1;

__END__

=encoding UTF-8

=head1 NAME

IO::K8s::Role::Namespaced - Role for Kubernetes resources that live in a namespace

=head1 SYNOPSIS

    package IO::K8s::Api::Core::V1::Pod;
    use IO::K8s::APIObject;
    with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

This role marks Kubernetes resources that are namespace-scoped (as opposed to
cluster-scoped). Resources like Pods, Services, Deployments, etc. consume this
role. Cluster-scoped resources like Nodes, Namespaces, ClusterRoles do not.

You can check if a resource is namespaced:

    if ($class->does('IO::K8s::Role::Namespaced')) {
        print "This resource is namespace-scoped\n";
    }

=head1 SEE ALSO

L<IO::K8s::Role::APIObject>, L<IO::K8s::APIObject>

=cut
