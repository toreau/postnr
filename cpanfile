requires 'IO::Socket::SSL';
requires 'Mojolicious';

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::Mojo';
};
