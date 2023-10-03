

#!/bin/bash

# update the package lists

sudo apt-get update

# upgrade the Apache HTTP Server and ModSecurity packages

sudo apt-get install --only-upgrade ${APACHE_PACKAGE_NAME} ${MODSECURITY_PACKAGE_NAME}

# restart the Apache web server to apply the changes

sudo systemctl restart apache2.service