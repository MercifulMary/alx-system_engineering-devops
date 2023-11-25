# Installs flask

package { 'flask':
  ensure   => '2.1.0',
  require  => Package['werkzeug'],
  provider => 'pip3',
}

package { 'werkzeug':
  ensure   => '2.2.2',
  provider => 'pip3',
}
