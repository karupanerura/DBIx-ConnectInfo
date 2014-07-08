use strict;
use warnings;
use utf8;

use Test::More tests => 8;
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

is $connect_info->dbd,      'mysql',             'dbd';
is $connect_info->host,     'myapp.mysql.local', 'host';
is $connect_info->port,     3306,                'port';
is $connect_info->database, 'myapp',             'database';
is $connect_info->user,     'foo',               'user';
is $connect_info->password, 'bar',               'password';
is_deeply $connect_info->attribute, {
    RaiseError => 1,
}, 'attribute';

my ($file, $line) = (__FILE__, __LINE__); eval { $connect_info->brabrabra };
is $@, qq{Can't locate object method "brabrabra" via package "DBIx::ConnectInfo" at $file line $line.\n},
    'should die when access to wrong attribute.';
