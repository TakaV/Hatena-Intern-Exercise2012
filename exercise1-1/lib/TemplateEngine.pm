package TemplateEngine;

use strict;
use warnings;

use File::Slurp;
use HTML::Entities;

use Class::Accessor::Lite (
  new => 1,
  rw  => [ qw/ file / ],
);

sub render {
    my ($self, $context) = @_;

    my $file            = read_file($self->file);
    my $encoded_context = { map { $_ => $self->_escape($context->{$_}) } keys %$context };

    $file =~ s/{%\s(.*)\s%}/$encoded_context->{$1}/g;

    return $file;
}

sub _escape {
    my ($self, $string) = @_;

    return encode_entities($string, '<>&"');
}

1;
