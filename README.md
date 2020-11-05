# docker-weblogic
Provides builds for ch-oraclelinux, ch-serverjre and ch-weblogic images


## ch-oraclelinux
This build extends the oracle/oraclelinux:7-slim image and adds some additional tools, such as vim, less, ps & top.

To build the image, from the root of the repo run:

    docker build -t ch-oraclelinux ch-oraclelinux/

## ch-serverjre
This build extends the ch-oraclelinux image to install the Oracle Java Server JRE 8.  

The JRE needs to be downloaded separately from Oracle, as it is a licensed product, and can be obtained from https://www.oracle.com/java/technologies/javase-server-jre8-downloads.html. Select the Linux 64bit version with a name that follows the pattern `server-jre-8uNNN-linux-x64.tar.gz`, where NNN is the minor version.  The latest version at the time of writing is `server-jre-8u271-linux-x64.tar.gz`
Place the downloaded JRE inside the `ch-oraclelinux` folder before building.

To build the image, from the root of the repo run:

    docker build -t ch-serverjre ch-serverjre/
   
## ch-weblogic
This build extends the ch-serverjre image to install the Oracle WebLogic Server 12.1.3, and the latest Patch Set Update (PSU) for October 2020.  

The WebLogic server installation and PSU need to be downloaded separately from Oracle, as they are licensed products.  
The WebLogic installation can be obtained from http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html.  Select the generic installer for 12.1.3 `fmw_12.1.3.0.0_wls.jar`, as that can be used for production.  
The PSU can be obtained from Oracle support https://support.oracle.com/epmos/faces/DocumentDisplay?id=2694898.1 The required patch file is `p31656851_121300_Generic.zip`.

Place the two downloaded files, inside the `ch-weblogic` folder before building.

To build the image, from the root of the repo run:

    docker build -t ch-weblogic ch-weblogic/
   
This build will result in a large image ~ 4GB in size.  To reduce the size down to a more manageable ~1.2GB, you can use the experimental `--squash` flag when running the build.  To use this, you will need to enable experimental features for the docker client.

    docker build -t ch-weblogic --squash ch-weblogic/
