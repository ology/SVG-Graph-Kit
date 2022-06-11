#!perl
use strict;
use warnings;

use Test::More;
use Test::Exception;

use_ok 'SVG::Graph::Kit';

my $g = new_ok 'SVG::Graph::Kit';

my $data = [ [ 1,  2,  0 ],
             [ 3,  5,  1 ],
             [ 4,  7,  2 ],
             [ 5, 11,  3 ],
             [ 6, 13,  5 ],
             [ 7, 17,  8 ],
             [ 8, 19, 13 ],
             [ 9, 23, 21 ],
             [10, 29, 34 ] ];

$g = new_ok 'SVG::Graph::Kit' => [ data => $data ];

# Test statistics calls.
for my $dim (qw(x y z)) {
    for my $stat (qw(min max mean median range stdv percentile)) {
        my $n = $g->stat($dim, $stat, 90); # 90 for 90th percentile
        ok defined $n, "$dim $stat = $n";
        # mode() not tested as there are no ties in the data.
    }
}

lives_ok { $g->draw } 'draw lives';

done_testing();

__END__
# DEBUG:
my $output = "$0.svg";
if ($output =~ /^([\/\w .-]+)$/) {
    $output = $1;
}
else {
    die "Disallowed characters in filename: '$output'";
}
open my $fh, '>', $output or die "Can't write to $output: $!\n";
print $fh $d, "\n";
