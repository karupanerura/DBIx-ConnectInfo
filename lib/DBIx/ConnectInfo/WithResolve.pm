package DBIx::ConnectInfo::WithResolve;
use 5.008001;
use strict;
use warnings;
use utf8;

use parent qw/DBIx::ConnectInfo/;

use Socket ();

sub new {
    my ($class, %args) = @_;
    my $resolver = exists $args{resolver} ? delete $args{resolver} : $class->can('_resolver');
    my $self = $class->SUPER::new(%args);
    $self->{resolver} = $resolver;
    return $self;
}

sub _resolver {
    my $ipaddr = Socket::inet_aton(@_);
    return unless $ipaddr;
    return Socket::inet_ntoa($ipaddr);
}

sub _get_attr {
    my ($self, $key) = @_;
    if ($key eq 'hostname' || $key eq 'host') {
        my $hostname = $self->SUPER::_get_attr($key) or return;
        return $self->{resolver}->($hostname);
    }
    else {
        return $self->SUPER::_get_attr($key);
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

DBIx::ConnectInfo::WithResolve - DBIx::ConnectInfo with DNS resolver

=head1 SYNOPSIS

    use DBI;
    use DBIx::ConnectInfo::WithResolve;

    my $connect_info = DBIx::ConnectInfo::WithResolve->new(
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

    ....

=head1 DESCRIPTION

DBIx::ConnectInfo is ...

=head1 SEE ALSO

L<DBIx::DSN::WithResolve>

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

