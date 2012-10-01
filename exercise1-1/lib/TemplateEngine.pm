package TemplateEngine;

use strict;
use warnings;

use IO::File;
use HTML::Entities;

use Class::Accessor::Lite (
  new => 1,
  rw  => [ qw/ file / ],
);

sub render {
    my ($self, $opts) = @_;

    my $file         = $self->_read;
    my $encoded_opts = { map { $_ => $self->_escape($opts->{$_}) } keys %$opts };

    my $result;
    while (my $l = $file->getline) {
        $l =~ s/{%\s(.*)\s%}/$encoded_opts->{$1}/g;

        $result .= $l;
    }

    return $result;
}

sub _read {
    return IO::File->new(shift->{file}, 'r');
}

sub _escape {
    my ($self, $string) = @_;

    return encode_entities($string, '<>&"');
}

1;
