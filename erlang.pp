class erlang_install {
  $desired_version = '20.3'

  $current_version = inline_template('<%= scope(functions["dpkgquery"]("erlang")) %>')

  package { 'esl-erlang':
    ensure => installed,
    notify => Exec['download-install-erlang'],
  }

  exec { 'download-install-erlang':
    command => "wget https://packages.erlang-solutions.com/ubuntu/pool/esl-erlang_${desired_version}~ubuntu~$(lsb_release -c -s)_amd64.deb -O /tmp/esl-erlang.deb && dpkg -i /tmp/esl-erlang.deb",
    creates => '/usr/lib/erlang/erts-' + $desired_version,
    require => Package['esl-erlang'],
  }
}