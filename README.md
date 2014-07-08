# NAME

DBIx::ConnectInfo - connect info manager for DBI

# SYNOPSIS

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

# DESCRIPTION

DBIx::ConnectInfo is ...

# LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

karupanerura <karupa@cpan.org>
