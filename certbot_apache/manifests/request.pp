define certbot_apache::request (
  $certbot_domains,
  $certbot_email,
  $agree_tos,
  $eff_email,
  $https_redirect,
  $notify = undef,
) {

    $domain_args = join("-d",$certbot_domains,'-d')

    if !$agree_tos {
      fail("YOU MUST AGREE TO THE LETSENCRYPT TOS TO REQUEST CERTIFICATES (read tos and then set agree_tos=>true")
    }

    if $eff_email {
      $eff_email_arg = "--eff-email"
    } else {
      $eff_email_arg = "--no-eff-email"     
    }

    exec {
	'certbot_update':
	    require => [
			Package['certbot'],
		        Package['python3-certbot-apache'],
			],
	    command => 'echo certbot --keep-until-expiring --apache -m $certbot_email $eff_email_arg $domain_args',
            notify => $notify,
	    logoutput => true,
    }
    
}
