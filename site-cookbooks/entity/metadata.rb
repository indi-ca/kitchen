name             "entity"
maintainer       "Indika"
maintainer_email "indika@github.com"
license          "Apache 2.0"
description      "Instantiates the entity"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "python"
depends "database"

depends "rbenv"

depends "nginx"

#depends 'nginx::http_gzip_static_module'
#depends 'nginx::http_ssl_module'

#depends "http_gzip_static_module"
#depends "database::postgresql"
