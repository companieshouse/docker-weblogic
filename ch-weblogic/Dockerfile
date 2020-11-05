FROM ch-serverjre as builder

ENV ORACLE_HOME=/apps/oracle \
    WL_PKG=fmw_12.1.3.0.0_wls.jar

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d $ORACLE_HOME -m -s /bin/bash weblogic

COPY $WL_PKG response.file oraInst.loc /apps

# Install WebLogic as the weblogic user
USER weblogic
RUN $JAVA_HOME/bin/java -jar /apps/$WL_PKG -ignoreSysPrereqs -novalidation -silent -responseFile /apps/response.file -invPtrLoc /apps/oraInst.loc -jreLoc $JAVA_HOME ORACLE_HOME=$ORACLE_HOME INSTALL_TYPE="WebLogic Server"

# Apply latest patch
ARG PATCH_NUMBER=31656851

COPY p${PATCH_NUMBER}_*.zip $ORACLE_HOME

RUN cd $ORACLE_HOME && \
    unzip p${PATCH_NUMBER}_*.zip && \
    cd ${PATCH_NUMBER} && \
    $ORACLE_HOME/OPatch/opatch apply -silent && \
    $ORACLE_HOME/OPatch/opatch lsinventory

FROM ch-serverjre

ENV ORACLE_HOME=/apps/oracle

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d $ORACLE_HOME -m -s /bin/bash weblogic

COPY --from=builder $ORACLE_HOME/wlserver $ORACLE_HOME/wlserver
COPY --from=builder $ORACLE_HOME/oracle_common $ORACLE_HOME/oracle_common

RUN chown weblogic:weblogic -R /apps

USER weblogic
WORKDIR $ORACLE_HOME

CMD ["bash"]
