package HTML::FormFu::Plugin::Catalyst::StashContextMethods;

use strict;
use base 'HTML::FormFu::Plugin';
use Class::C3;
use Carp qw( croak );

use HTML::FormFu::Attribute qw/ mk_attr_accessors /;

__PACKAGE__->mk_attr_accessors(qw/ stash_key methods /);

sub process {
    my ( $self ) = @_;

    for my $arg (qw/ stash_key methods /) {
        croak "'$arg' config missing"
            if !defined $self->$arg;
    }

    my $form    = $self->form;
    my $value   = $form->stash->{context};
    my $methods = $self->methods;

    $methods = [$methods] if ref $methods ne 'ARRAY';

    for my $method (@$methods) {
        $value = $value->$method;
    }

    $form->stash->{ $self->stash_key } = $value;

    return;
}

1;

__END__

=head1 NAME

HTML::FormFu::Plugin::Catalyst::StashContextMethods - stash context values

=head1 SYNOPSIS

    ---
    plugins:
      - type: 'Catalyst::StashContextMethods'
        stash_key: user_id
        methods: [user, obj, id]

=head1 SEE ALSO

Is a sub-class of, and inherits methods from L<HTML::FormFu::Plugin>

L<HTML::FormFu::FormFu>

=head1 AUTHOR

Carl Franks C<cfranks@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.
