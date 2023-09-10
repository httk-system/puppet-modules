define certbot_apache::request (
  $certbot_domains,
  $certbot_email,
  $agree_tos,
  $eff_email,
  $https_redirect,
  $notify = undef,
) {

    $domain_args = $certbot_domains.join(' -d ')

    if !$agree_tos {
      fail("YOU MUST AGREE TO THE LETSENCRYPT TOS TO REQUEST CERTIFICATES (read tos and then set agree_tos=>true")
    }

    if $eff_email {
      $eff_email_arg = "--eff-email"
    } else {
      $eff_email_arg = "--no-eff-email"
    }

    if $https_redirect {
      $redirect_arg = "--redirect"
    } else {
      $redirect_arg = "--no-redirect"
    }

    exec {
	"certbot_request_$name":
	    require => [
			Package['certbot'],
		        Package['python3-certbot-apache'],
			],
	    command => "certbot -n --keep-until-expiring --expand --apache -m $certbot_email $eff_email_arg $redirect_arg -d $domain_args",
	    provider => shell,
            notify => $notify,
	    logoutput => true,
    }

}
