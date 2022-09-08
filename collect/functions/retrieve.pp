function collect::retrieve(
    $category,
){
    ensure_resource('file',"/root/collectors/$category",{ensure => 'directory',owner => 'root',mode => '0700'})
    $param_dirs = glob("/root/collectors/$category/*")

    $param_dirs.reduce({}) |$result, $dir| {
      $result + { basename($dir) => glob("$dir/*").map |$file| {
          split(file($file),"\\|")
        }.reduce([]) |$car, $cdr| {
          $car + $cdr
        }
      }
    }
}
