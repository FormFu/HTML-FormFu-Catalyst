#!usr/bin/perl
use warnings;
use strict;

my $EXPECTED = 42;
{   package My::Context;
    sub new { bless {}, shift }
    sub m1 {
        my ($self) = @_;
        ++$self->{called}{m1};
        return $self
    }
    sub m2 {
        my ($self) = @_;
        ++$self->{called}{m2};
        return $self
    }
    sub m3 {
        my ($self) = @_;
        return $EXPECTED
    }
}

{   package My::Form;
    sub new { bless {}, shift }
    sub stash { $_[0]{stash} }
}

my $STASH_KEY = 'scm';
{   package HTML::FormFu::Plugin::Catalyst::StashContextMethods::Test;
    use base 'HTML::FormFu::Plugin::Catalyst::StashContextMethods';
    sub stash_key { $STASH_KEY }
    sub methods { ['m1', 'm2', 'm3'] }
    sub form { $_[0]{form} }
}

use Test::More tests => 3;

my $scm = HTML::FormFu::Plugin::Catalyst::StashContextMethods::Test->new;
$scm->{form} = My::Form->new;
$scm->{form}{stash}{context} = My::Context->new;

$scm->process;

is $scm->form->stash->{$STASH_KEY}, $EXPECTED, 'Expected value set';
is $scm->form->stash->{context}{called}{m1}, 1, 'm1 called';
is $scm->form->stash->{context}{called}{m2}, 1, 'm2 called';
