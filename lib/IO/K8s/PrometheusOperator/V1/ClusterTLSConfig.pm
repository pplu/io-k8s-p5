package IO::K8s::PrometheusOperator::V1::ClusterTLSConfig;
# ABSTRACT: clusterTLS defines the mutual TLS configuration for the Alertmanager cluster's gossip protocol.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s client => '+IO::K8s::PrometheusOperator::V1::SafeTLSConfig', { required => 'schema' };
k8s server => '+IO::K8s::PrometheusOperator::V1::WebTLSConfig', { required => 'schema' };

=attr client

client defines the client-side configuration for mutual TLS.

=cut

=attr server

server defines the server-side configuration for mutual TLS.

=cut

1;
