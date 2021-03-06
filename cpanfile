requires 'Moose';
requires 'JSON::MaybeXS';
requires 'Module::Runtime';

on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Exception';
  requires 'Test::Class::Moose::Load';
};

on 'develop' => sub {
  requires 'KubeBuilder';
};
