FROM ch-serverjre as builder

ENV ORACLE_HOME=/apps/oracle \
    WL_PKG=fmw_12.2.1.4.0_wls_lite_generic.jar \
    OPATCH_NO_FUSER=true

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d $ORACLE_HOME -m -s /bin/bash weblogic

COPY $WL_PKG response.file oraInst.loc /apps

# Install WebLogic as the weblogic user
USER weblogic
RUN $JAVA_HOME/bin/java -jar /apps/$WL_PKG -ignoreSysPrereqs -novalidation -silent -responseFile /apps/response.file -invPtrLoc /apps/oraInst.loc -jreLoc $JAVA_HOME ORACLE_HOME=$ORACLE_HOME INSTALL_TYPE="WebLogic Server"

# Apply latest patch for OPatch
ARG PATCH_NUMBER=28186730

COPY p${PATCH_NUMBER}_*.zip $ORACLE_HOME

RUN cd $ORACLE_HOME && \
    unzip p${PATCH_NUMBER}_*.zip && \
    $JAVA_HOME/bin/java -jar 6880880/opatch_generic.jar -silent oracle_home=$ORACLE_HOME

# Apply latest patch for WebLogic
ARG PATCH_NUMBER=32253037

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
COPY --from=builder $ORACLE_HOME/oraInst.loc $ORACLE_HOME/oraInst.loc
COPY --from=builder $ORACLE_HOME/inventory $ORACLE_HOME/inventory
COPY --from=builder $ORACLE_HOME/oui $ORACLE_HOME/oui

RUN chown weblogic:weblogic -R /apps

USER weblogic
WORKDIR $ORACLE_HOME

CMD ["bash"]
