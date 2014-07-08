use strict;
use warnings;
use utf8;

use Test::More;
use DBIx::ConnectInfo::WithResolve;

subtest 'host' => sub {
    my $connect_info = DBIx::ConnectInfo::WithResolve->new(
        dbd       => 'mysql',
        host      => 'localhost',
        user      => 'foo',
        password  => 'bar',
        attribute => {
            RaiseError => 1,
        },
    );

    is $connect_info->host, '127.0.0.1', 'host';
    is $connect_info->dsn,  'DBI:mysql:host=127.0.0.1', 'dsn';
};

subtest 'hostname' => sub {
    my $connect_info = DBIx::ConnectInfo::WithResolve->new(
        dbd       => 'mysql',
        hostname  => 'localhost',
        user      => 'foo',
        password  => 'bar',
        attribute => {
            RaiseError => 1,
        },
    );

    is $connect_info->hostname, '127.0.0.1', 'hostname';
    is $connect_info->dsn,      'DBI:mysql:hostname=127.0.0.1', 'dsn';
};


subtest 'override resolver' => sub {
    my $connect_info = DBIx::ConnectInfo::WithResolve->new(
        dbd       => 'mysql',
        hostname  => 'localhost',
        user      => 'foo',
        password  => 'bar',
        attribute => {
            RaiseError => 1,
        },
        resolver => sub { $_[0] },
    );

    is $connect_info->hostname, 'localhost', 'hostname';
    is $connect_info->dsn,      'DBI:mysql:hostname=localhost', 'dsn';
};

done_testing;
