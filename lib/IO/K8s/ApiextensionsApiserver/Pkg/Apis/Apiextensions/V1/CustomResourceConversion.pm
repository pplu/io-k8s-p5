package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceConversion;
# ABSTRACT: CustomResourceConversion describes how to convert different versions of a CR.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s strategy => Str, 'required';

=attr strategy

strategy specifies how custom resources are converted between versions. Allowed values are: - `"None"`: The converter only change the apiVersion and would not touch any other field in the custom resource. - `"Webhook"`: API Server will call to an external webhook to do the conversion. Additional information is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhook to be set.

=cut

k8s webhook => 'Apiextensions::V1::WebhookConversion';

=attr webhook

webhook describes how to call the conversion webhook. Required when `strategy` is set to `"Webhook"`.

=cut

1;
