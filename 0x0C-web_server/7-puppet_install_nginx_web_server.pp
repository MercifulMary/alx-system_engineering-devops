# puppet manifest to configure nginx

# install nginx
exec {'cmd':
  command => 'sudo apt-get update && sudo apt-get install -y nginx',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# change folder rights
exec { 'chmod www folder':
  command => 'chmod -R 755 /var/www',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# create index file
file { '/var/www/html/index.html':
  content => "Hello World!\n",
}

# create index file
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page\n",
}

# add redirection and error page
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  path    => '/etc/nginx/sites-available/default',
  content =>
"server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        location / {
                try_files \$uri \$uri/ =404;
        }
        error_page 404 /404.html;
        location  /404.html {
            internal;
        }
        
        if (\$request_filename ~ redirect_me){
            rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
        }
}
",
  require => Exec['cmd'],
}

exec {'restart service':
  command => 'sudo service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
  require => Exec['cmd'],
}

exec {'sym link':
  command => 'ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/',
  require => File['/etc/nginx/sites-available/default'],
  path    => '/usr/bin:/usr/sbin:/bin',
}
# restart nginx
#exec { 'restart service':
#  command => 'service nginx restart',
#  path    => '/usr/bin:/usr/sbin:/bin',
#}

# start service nginx
#service { 'nginx':
#  ensure     => running,
#  enable     => true,
# hasrestart => true,
# require    => Package['nginx'],
#}
