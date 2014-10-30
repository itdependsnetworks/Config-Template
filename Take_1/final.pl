#!/usr/bin/perl


 use HTML::Template;
 use CGI qw(:standard);


print "Content-Type: text/plain\n\n";

my $HOSTNAME = param('HOSTNAME' );
my $SECRETPASSWORD = param('SECRETPASSWORD' );
my $VLAN = param('VLAN' );
my $SWITCHIP = param('SWITCHIP' );
my $SWITCHMASK = param('SWITCHMASK' );
my $SNMPLOCATION = param('SNMPLOCATION' );
my $SNMPRO = param('SNMPRO' );
my $SNMPRW = param('SNMPRW' );
my $SNMPCONTACT = param('SNMPCONTACT' );
my $UPLINK = param('UPLINK' );
my $UPLINKDESC = param('UPLINKDESC' );
my $PASSWORD = param('PASSWORD' );

my $switch = HTML::Template->new(filename => 'switch.tmpl' );

$switch->param('HOSTNAME' => $HOSTNAME );
$switch->param('SECRETPASSWORD' => $SECRETPASSWORD );
$switch->param('VLAN' => $VLAN );
$switch->param('SWITCHIP' => $SWITCHIP );
$switch->param('SWITCHMASK' => $SWITCHMASK );
$switch->param('SNMPLOCATION' => $SNMPLOCATION );
$switch->param('SNMPRO' => $SNMPRO );
$switch->param('SNMPRW' => $SNMPRW );
$switch->param('SNMPCONTACT' => $SNMPCONTACT );
$switch->param('UPLINK' => $UPLINK );
$switch->param('UPLINKDESC' => $UPLINKDESC );
$switch->param('PASSWORD' => $PASSWORD );

my @switch =  $switch->output;

print @switch;
