FROM httpd:2.4
 
ENV PLUGIN_PATH=modules/WLSPlugin12.2.1.4.0
ENV LD_LIBRARY_PATH=${HTTPD_PREFIX}/${PLUGIN_PATH}

# Copy the WebLogic Apache plugin module and libs onto the image   
COPY lib ${PLUGIN_PATH}

# Use a custom start script to allow creation of exportedlogs/apache directory before startup
COPY start-apache.sh bin/start-apache.sh
RUN chmod +x bin/start-apache.sh

# Reference the plugin module
RUN sed -i '/mod_rewrite.so$/a LoadModule weblogic_module modules\/WLSPlugin12.2.1.4.0\/mod_wl_24.so' conf/httpd.conf

CMD ["/usr/local/apache2/bin/start-apache.sh"]
