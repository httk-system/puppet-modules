function collect::store(
    $category,
    $title,
    $data,
    $final,
){
    ensure_resource('file',"/root/collectors/$category",{ensure => 'directory',owner => 'root',mode => '0700'})
    $data.each |$key, $val| {
      if $val {
        if $val.is_a(Array) {
          if length($val) > 0 {
            ensure_resource('file',"/root/collectors/$category/$key",{ensure => 'directory',owner => 'root',mode => '0700'})
            file { "/root/collectors/$category/$key/$title":
              ensure  => 'file',
              mode    => '0755',
              content => join($val,'|'),
              before => $final,
            }
          }
        } else {
          ensure_resource('file',"/root/collectors/$category/$key",{ensure => 'directory',owner => 'root',mode => '0700'})
          file { "/root/collectors/$category/$key/$title":
            ensure  => 'file',
            mode    => '0755',
            content => $val,
            before => $final,
          }
        }
      }
    }
}
