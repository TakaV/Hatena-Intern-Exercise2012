package TemplateEngine;

use strict;
use warnings;

use File::Slurp;
use HTML::Entities;
use List::Util qw(shuffle);

use Class::Accessor::Lite (
  new => 1,
  rw  => [ qw/ file / ],
);

sub render {
    my ($self, $context) = @_;

    my $file = read_file($self->file);

    for my $key (keys %$context) {
        $context->{$key} = $self->_shuffle_text($context->{$key});
        $context->{$key} = $self->_escape($context->{$key});
    }

    $file =~ s/{%\s(.*)\s%}/$context->{$1}/g;

    return $file;
}

sub _escape {
    my ($self, $string) = @_;

    return encode_entities($string, '<>&"');
}

sub _shuffle_text {
    my ($self, $texts) = @_;

    return $texts if ref($texts) ne "ARRAY";
    return [ shuffle @$texts ]->[0];
}


1;
