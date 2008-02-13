package HTML::FormFu::Plugin::Catalyst::StashUserID;

use strict;
use base 'HTML::FormFu::Plugin';
use Class::C3;

use HTML::FormFu::Attribute qw/ mk_accessors /;

__PACKAGE__->mk_accessors(qw/ stash_key /);

sub new {
    my $class = shift;

    my $self = $class->next::method(@_);

    $self->stash_key('user_id')
        if !defined $self->stash_key;

    return $self;
}

sub process {
    my ( $self ) = @_;

    my $stash = $self->form->stash;

    $stash->{ $self->stash_key } = $stash->{context}->user->id;

    return;
}

1;

__END__

=head1 NAME

HTML::FormFu::Plugin::Catalyst::StashUserID - place user ID onto form stash

=head1 SYNOPSIS

    ---
    plugins:
      - 'Catalyst::StashUserID'

=head1 METHODS

=head2 stash_key

Defaults to C<user_id>.

=head1 SEE ALSO

Is a sub-class of, and inherits methods from L<HTML::FormFu::Plugin>

L<HTML::FormFu::FormFu>

=head1 AUTHOR

Carl Franks C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.
