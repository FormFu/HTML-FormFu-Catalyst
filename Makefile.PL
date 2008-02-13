use inc::Module::Install;

name 'HTML-FormFu-Catalyst';
perl_version '5.008001';
all_from 'lib/HTML/FormFu/Catalyst.pm';

requires 'Class::C3';
requires 'HTML::FormFu';

#test_requires 'Test::MockObject';

auto_install();
&WriteAll;
