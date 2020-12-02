FROM httpd:2.4

ENV PLUGIN_PATH=modules/WLSPlugin12.2.1.4.0
ENV LD_LIBRARY_PATH=${HTTPD_PREFIX}/${PLUGIN_PATH}

# Copy the WebLogic Apache plugin module and libs onto the image   
COPY lib ${PLUGIN_PATH}

# Reference the plugin module
RUN sed -i '/mod_rewrite.so$/a LoadModule weblogic_module modules\/WLSPlugin12.2.1.4.0\/mod_wl_24.so' conf/httpd.conf
