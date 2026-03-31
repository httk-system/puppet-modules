class webserver::apache_proxy_modules {
  class { 'apache::mod::proxy': }
  class { 'apache::mod::proxy_http': }
  class { 'apache::mod::headers': }
}

