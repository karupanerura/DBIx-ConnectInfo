package DBIx::ConnectInfo;
use 5.008001;
use strict;
use warnings;
use utf8;
use Carp qw/croak/;

our $VERSION = "0.01";

use overload '@{}' => sub { [shift->for_dbi] };

our @REQUIRED         = qw/dbd user password/;
our @NO_DSN_ATTRIBUTE = qw/dbd user password attribute/;

sub new {
    my ($class, %attr) = @_;
    for my $key (@REQUIRED) {
        croak "$key is required." unless exists $attr{$key};
    }
    return bless {
        attr => \%attr
    } => $class;
}

sub keys :method {
    my $self = shift;
    return keys %{ $self->{attr} };
}

sub dsn {
    my $self = shift;

    my %no_dsn_attribute = map { $_ => 1 } @NO_DSN_ATTRIBUTE;
    return sprintf 'DBI:%s:%s', $self->dbd, join ';', map {
        join '=', $_, $self->$_
    } grep { !$no_dsn_attribute{$_} } sort $self->keys;
}

sub for_dbi {
    my $self = shift;
    return (
        $self->dsn,
        $self->user,
        $self->password,
        $self->attribute,
    );
}

sub _get_attr {
    my ($self, $key) = @_;
    return unless exists $self->{attr}->{$key};
    return $self->{attr}->{$key};
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $self = shift;
    (my $method = $AUTOLOAD) =~ s/^.+://;
    if (exists $self->{attr}->{$method}) {
        return $self->_get_attr($method);
    }
    else {
        my $class = ref $self;
        Carp::croak qq{Can't locate object method "$method" via package "$class"};
    }
}

sub DESTROY {} ## no autoload

1;
__END__

=encoding utf-8

=head1 NAME

DBIx::ConnectInfo - connect info manager for DBI

=head1 SYNOPSIS

    use DBI;
    use DBIx::ConnectInfo;

    my $connect_info = DBIx::ConnectInfo->new(
        dbd       => 'mysql',
        host      => 'myapp.mysql.local',
        port      => 3306,
        database  => 'myapp',
        user      => 'foo',
        password  => 'bar',
        attribute => {
            RaiseError => 1,
        },
    );

    my $dbh = DBI->connect(@$connect_info);
    # or DBI->connect($connect_info->for_dbi);
    # or DBI->connect($connect_info->dsn, $connect_info->user, $connect_info->password, $connect_info->attribute);
    ....

=head1 DESCRIPTION

DBIx::ConnectInfo is ...

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

