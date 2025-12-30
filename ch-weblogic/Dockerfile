FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:2.0.0 AS builder

ENV ORACLE_HOME=/apps/oracle \
    WL_PKG=fmw_14.1.2.0.0_wls.jar \
    OPATCH_NO_FUSER=true

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d $ORACLE_HOME -m -s /bin/bash weblogic && \
    yum -y install make

COPY $WL_PKG response.file oraInst.loc /apps/

# Install WebLogic as the weblogic user
USER weblogic
RUN $JAVA_HOME/bin/java -jar /apps/$WL_PKG -ignoreSysPrereqs -novalidation -silent -responseFile /apps/response.file -invPtrLoc /apps/oraInst.loc -jreLoc $JAVA_HOME ORACLE_HOME=$ORACLE_HOME INSTALL_TYPE="WebLogic Server"

# Apply latest patch for OPatch
ARG PATCH_NUMBER=28186730

COPY p${PATCH_NUMBER}_*.zip $ORACLE_HOME

RUN cd $ORACLE_HOME && \
    unzip p${PATCH_NUMBER}_*.zip && \
    $JAVA_HOME/bin/java -jar 6880880/opatch_generic.jar -ignoreSysPrereqs -silent oracle_home=$ORACLE_HOME

# Apply latest patches for WebLogic

COPY --chown=weblogic weblogic-patches $ORACLE_HOME/weblogic-patches/

RUN cd $ORACLE_HOME/weblogic-patches && \
    for PATCH_FILE in $(ls -1 p*.zip); do \
        PATCH_NUMBER=${PATCH_FILE:1:8}; \
        unzip p${PATCH_NUMBER}_*.zip && \
        cd ${PATCH_NUMBER} && \
        $ORACLE_HOME/OPatch/opatch apply -silent && \
        $ORACLE_HOME/OPatch/opatch lsinventory && \
        cd ..; \
    done


FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:2.0.0

ENV ORACLE_HOME=/apps/oracle

RUN mkdir -p /apps && \
    chmod a+xr /apps && \
    useradd -d $ORACLE_HOME -m -s /bin/bash weblogic

USER weblogic
COPY --from=builder --chown=weblogic $ORACLE_HOME/wlserver $ORACLE_HOME/wlserver
COPY --from=builder --chown=weblogic $ORACLE_HOME/oracle_common $ORACLE_HOME/oracle_common
COPY --from=builder --chown=weblogic $ORACLE_HOME/oraInst.loc $ORACLE_HOME/oraInst.loc
COPY --from=builder --chown=weblogic $ORACLE_HOME/inventory $ORACLE_HOME/inventory
COPY --from=builder --chown=weblogic $ORACLE_HOME/OPatch $ORACLE_HOME/OPatch
COPY --from=builder --chown=weblogic $ORACLE_HOME/oui $ORACLE_HOME/oui
COPY --from=builder --chown=weblogic $ORACLE_HOME/jlib $ORACLE_HOME/jlib
COPY --from=builder --chown=weblogic $ORACLE_HOME/coherence $ORACLE_HOME/coherence

WORKDIR $ORACLE_HOME
CMD ["bash"]
