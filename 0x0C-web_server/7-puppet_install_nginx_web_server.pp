# puppet manifest to configure nginx

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure NGINX listening on port 80 and serving Hello World! on root
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable redirect configuration
file { '/etc/nginx/sites-available/redirect':
  ensure  => file,
  content => template('nginx/redirect.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

file { '/etc/nginx/sites-enabled/redirect':
  ensure => link,
  target => '/etc/nginx/sites-available/redirect',
  require => File['/etc/nginx/sites-available/redirect'],
  notify => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
