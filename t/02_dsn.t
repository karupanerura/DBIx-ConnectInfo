use strict;
use warnings;
use utf8;

use Test::More tests => 1;
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

is $connect_info->dsn, 'DBI:mysql:database=myapp;host=myapp.mysql.local;port=3306', 'dsn';
