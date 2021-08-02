# docker-weblogic
Provides builds for ch-oraclelinux, ch-serverjre, ch-weblogic and ch-apache images


## ch-oraclelinux
This build extends the oracle/oraclelinux:7-slim image and adds some additional tools, such as vim, less, ps & top.

To build the image, from the root of the repo run:

    docker build -t ch-oraclelinux ch-oraclelinux/

## ch-serverjre
This build extends the ch-oraclelinux image to install the Oracle Java Server JRE 8.  

The JRE needs to be downloaded separately from Oracle, as it is a licensed product, and can be obtained from https://www.oracle.com/java/technologies/javase-server-jre8-downloads.html. Select the Linux 64bit version with a name that follows the pattern `server-jre-8uNNN-linux-x64.tar.gz`, where NNN is the minor version.  The latest version at the time of writing is `server-jre-8u301-linux-x64.tar.gz` 

Place the downloaded JRE inside the `ch-serverjre` directory before building.

Additional certificates can be imported into the Java trust store, during the build, by placing root or intermediate certificate pem files in the `certs` directory.

To build the image, from the root of the repo run:

    docker build -t ch-serverjre ch-serverjre/
   
## ch-weblogic
This build extends the ch-serverjre image to install the Oracle WebLogic Server 12.2.1.4, the latest Patch for OPatch, and further WebLogic patches.

The WebLogic server installation and patches need to be downloaded separately from Oracle, as they are licensed products.  
The WebLogic installation can be obtained from http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html.  Select the generic installer for 12.2.1.4, download the `fmw_12.2.1.4.0_wls_lite_Disk1_1of1.zip` file, and then extract the installer jar `fmw_12.2.1.4.0_wls_lite_generic.jar`.  

The patch for OPatch can be obtained from Oracle support https://support.oracle.com/epmos/faces/DocumentDisplay?id=2694898.1 The required patch file is `p28186730_139425_Generic.zip`.

Place the installer jar (`fmw_12.2.1.4.0_wls_lite_generic.jar`)  and OPatch patch file (`p28186730_139425_Generic.zip`) inside the `ch-weblogic` directory before building.  Optionally, further WebLogic patches can be placed inside the `ch-weblogic/weblogic-patches` directory, and the build will then iterate through those and attempt to install each of them in turn.

To build the image, from the root of the repo run:

    docker build -t ch-weblogic ch-weblogic/
   
This build will result in a large image ~ 4GB in size.  To reduce the size down to a more manageable ~1.2GB, you can use the experimental `--squash` flag when running the build.  To use this, you will need to enable experimental features for the docker client.

    docker build -t ch-weblogic --squash ch-weblogic/

## ch-apache
This build extends the official httpd:2.4 Apache image, https://hub.docker.com/_/httpd/, with the WebLogic Apache plugin 12.2.1.4.0.

The WebLogic Apache plugin needs to be downloaded manually from Oracle, as it is a licensed product.  The installation files can be obtained from https://www.oracle.com/uk/middleware/technologies/webtier-downloads.html

Place the downloaded `fmw_12.2.1.4.0_wlsplugins_Disk1_1of1.zip` file inside the ch-apache directory, prior to building, and then:
 - unzip the `fmw_12.2.1.4.0_wlsplugins_Disk1_1of1.zip` file
 - unzip the `WLSPlugins12c-12.2.1.4.0.zip` file
 - unzip the `WLSPlugin12.2.1.4.0-Apache2.2-Apache2.4-Linux_x86_64-12.2.1.4.0.zip` file

To build the image, from the root of the repo run:

    docker build -t ch-apache ch-apache/
