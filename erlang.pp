class erlang::add_repository {
  exec { 'add_erlang_repository':
    command => 'wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb -O /tmp/erlang-solutions.deb && dpkg -i /tmp/erlang-solutions.deb',
    path    => ['/bin', '/usr/bin'],
    creates => '/etc/apt/sources.list.d/erlang-solutions.list',
  }
}

class erlang::install {
  include erlang::add_repository

  package { 'esl-erlang':
    ensure => '1:20.3',
    require => Class['erlang::add_repository'], # Ensure the repository is added before installation
  }
}