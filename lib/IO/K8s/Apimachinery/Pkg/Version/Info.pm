package IO::K8s::Apimachinery::Pkg::Version::Info;
# ABSTRACT: Info contains versioning information. how we'll want to distribute that information.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s buildDate => Str, 'required';

k8s compiler => Str, 'required';

k8s gitCommit => Str, 'required';

k8s gitTreeState => Str, 'required';

k8s gitVersion => Str, 'required';

k8s goVersion => Str, 'required';

k8s major => Str, 'required';

k8s minor => Str, 'required';

k8s platform => Str, 'required';

1;
