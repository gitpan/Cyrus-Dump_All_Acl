#!/usr/bin/perl

use IMAP::Admin;
use strict;
use warnings;

sub main() {
    my $imap = IMAP::Admin->new('Server'    => 'localhost',
                            'Login'     => 'cyrus',
                            'Password'  => 'abcdefg',
                            'Port'      => 143,
                            'Separator' => ".",
                           );

    my @list = $imap->list("user.*");
    foreach my $box (@list) {
        print "-"x50,"\n";
        my @acl = $imap->get_acl($box);
        my @quota = $imap->get_quota($box);

        print $box;
        if($quota[2] && $quota[1]) { print "\nquota: ".$quota[1]."/".$quota[2] }

        my $user_acl = pop @acl;
        my $user = pop @acl;

        while($user) {
            print "\n\tusr: ".$user."\t";
            print "acl: ".$user_acl;

            $user_acl = pop @acl;
            $user = pop @acl;
        }
        print "\n";
    }
    $imap->close;
}

&main();

