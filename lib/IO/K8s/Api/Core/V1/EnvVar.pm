package IO::K8s::Api::Core::V1::EnvVar;
# ABSTRACT: EnvVar represents an environment variable present in a Container.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name of the environment variable. Must be a C_IDENTIFIER.

=cut

k8s value => Str;

=attr value

Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to "".

=cut

k8s valueFrom => 'Core::V1::EnvVarSource';

=attr valueFrom

Source for the environment variable's value. Cannot be used if value is not empty.

=cut

1;
