#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
# getting the data that the user wants to search for and access the search subroutine in the middle layer
my $query = $cgi->param('search');
my %result = Biocomp2::Middle::search($query);
print <<__EOF;
<html>
<head>
<title>Chromosome 16</title>
</head>
<body>
<h1>Chromosome 16</h1>
<tab3><form method="GET" action="search.pl">
<input type="text" name="search" placeholder="Search the database">
<input type="submit" value="Search"></form></tab3>

__EOF
print "<table>\n";
print "<thead>

foreach my $gene_id ( keys %result )
{	
	# link the gene_id back to details page
	my $uri = 'prog1.pl?data='.uri_escape($gene_id);
   	my $html = escapeHTML($gene_id);
	# making a new hash for the gene details for printing the results
	my %gene_details = %{$result{$gene_id}};
    	my $gene_name = $gene_details{"name"};
	my $gene_accession = $gene_details{"accession_version"};
	my $gene_locus= $gene_details{"locus"};
	print "  <tr>\n";
	print qq{<td><tab2><a href="$uri">$html</a></tab2></td> <td><tab2>$gene_name</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus</tab2></td> \n};
	print " </tr>\n";

}

print "</thead>";
print "</body> </html>";
