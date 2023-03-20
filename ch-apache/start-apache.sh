#!/bin/bash

# We want the logs to be stored in exportedlogs/apache instead of just logs
# This has to be done at run time, as the exportedlogs folder is only mounted at that point
mkdir -p /usr/local/apache2/exportedlogs/apache


if [ "${DISABLE_PROXY_SSL}" = true ]; then
  sed -i 's/WLProxySSL ON//g' /usr/local/apache2/conf/*.conf
fi

# Now start apache
httpd-foreground
