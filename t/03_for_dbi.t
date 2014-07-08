use strict;
use warnings;
use utf8;

use Test::More tests => 2;
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

is_deeply [$connect_info->for_dbi] => [
    'DBI:mysql:database=myapp;host=myapp.mysql.local;port=3306',
    'foo',
    'bar',
    {
        RaiseError => 1,
    },
], 'for_dbi';

is_deeply [@$connect_info] => [$connect_info->for_dbi], 'overload';
