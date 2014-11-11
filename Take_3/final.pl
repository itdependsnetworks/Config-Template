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
my $REGION = param('REGION' );
my $IPROUTE = param('IPROUTE' );


my ($AM,$EU,$AP) =();
if ($REGION eq 'AM' ){
	$AM = 1;
}
elsif ($REGION eq 'AP' ){
	$AP = 1;
}
elsif ($REGION eq 'EU' ){
	$EU = 1;
}

my $EIGRP = "router eigrp 1\n";
my @splitiproute = split(/,/,$IPROUTE);
foreach my $route ( @splitiproute){
	my @splitnet = split('/',$route);
	my $network = $splitnet[0];
	my $mask = $splitnet[1];
	my $wildmask = &make_mask($mask);
	$EIGRP .= "network $network $wildmask\n";
}


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
$switch->param('AM' => $AM );
$switch->param('AP' => $AP );
$switch->param('EU' => $EU );
$switch->param('EIGRP' => $EIGRP );


my @switch =  $switch->output;

print @switch;


sub make_mask {
        my %sub_conversion = (
		"8" => "0.255.255.255",
		"9" => "0.127.255.255",
		"10" => "0.63.255.255",
		"11" => "0.31.255.255",
		"12" => "0.15.255.255",
		"13" => "0.7.255.255",
		"14" => "0.3.255.255",
		"15" => "0.1.255.255",
		"16" => "0.0.255.255",
		"17" => "0.0.127.255",
		"18" => "0.0.63.255",
		"19" => "0.0.31.255",
		"20" => "0.0.15.255",
		"21" => "0.0.7.255",
		"22" => "0.0.3.255",
		"23" => "0.0.1.255",
		"24" => "0.0.0.255",
		"25" => "0.0.0.127",
		"26" => "0.0.0.63",
		"27" => "0.0.0.31",
		"28" => "0.0.0.15",
		"29" => "0.0.0.7",
		"30" => "0.0.0.3",
		"31" => "0.0.0.1",
		"32" => "0.0.0.0",
        );
        if ($_[1]){
                %rev_conv = reverse %sub_conversion;
                return  $rev_conv{$_[0]};
        }
        return $sub_conversion{$_[0]};
}
