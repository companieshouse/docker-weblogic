
# docker-weblogic

Provides builds for ch-oraclelinux, ch-serverjre, ch-weblogic and ch-apache images

## ch-oraclelinux

This build extends the oracle/oraclelinux:8 image and adds some additional tools, such as vim, less, ps & top.

To build the image, from the root of the repo run:

    docker build -t ch-oraclelinux ch-oraclelinux/

  

## ch-serverjre

This build extends the ch-oraclelinux image to install the Oracle JDK 21.

The JRE needs to be downloaded separately from Oracle, as it is a licensed product, and can be obtained from https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz.

We then rename the installation package from jdk-21_linux-x64_bin.tar.gz to jdk-21-21.?.?_linux-x64_bin.tar.gz to include the actual version number - e.g. jdk-21-21.0.8_linux-x64_bin.tar.gz

Place the downloaded JDK inside the `ch-serverjre` directory before building.

Additional certificates can be imported into the Java trust store, during the build, by placing root or intermediate certificate pem files in the `certs` directory.

To build the image, from the root of the repo run:

    docker build -t ch-serverjre ch-serverjre/

## ch-weblogic

This build extends the ch-serverjre image to install the Oracle WebLogic Server 14.1.2.0, the latest Patch for OPatch, and further WebLogic patches.

The WebLogic server installation and patches need to be downloaded separately from Oracle, as they are licensed products.

The patch for OPatch can be obtained from Oracle support https://support.oracle.com and is usually updated each quarter with the Oracle Critical Patch updates. The patch file should be named `p28186730_??????_Generic.zip`, where ?????? is the version number of the latest patch.

Place the installer jar (`fmw_14.1.2.0.0_wls.jar`) and OPatch patch file (`p28186730_??????_Generic.zip`) inside the `ch-weblogic` directory before building. Optionally, further WebLogic patches can be placed inside the `ch-weblogic/weblogic-patches` directory, and the build will then iterate through those and attempt to install each of them in turn.

To build the image, from the root of the repo run:

    docker build -t ch-weblogic ch-weblogic/

  

## ch-apache

This build extends the ch-serverjre image, with the WebLogic Apache plugin 14.1.2.0 and Apache httpd.

The WebLogic Apache plugin needs to be downloaded manually from Oracle, as it is a licensed product. The installation files can be obtained from https://www.oracle.com/uk/middleware/technologies/webtier-downloads.html.
Information on the configuration and prerequisites of the plugin can be found at https://docs.oracle.com/en/middleware/fusion-middleware/web-tier/14.1.2/develop-plugin/apache.html.

Unzip the `WLSPlugin14.1.2.0.0-Apache2.4-OpenSSL-1.1.1-Linux_x86_64.zip` file inside the `ch-apache` directory.

The httpd and apr libs are built from source during the image build, and the source needs to be provided to the build.  The source archives can be downloaded from the Apache project CDN - eg:

 - httpd - https://dlcdn.apache.org/httpd/httpd-2.4.65.tar.gz
 - apr - https://dlcdn.apache.org/apr/apr-1.7.6.tar.gz
 - apr-util - https://dlcdn.apache.org/apr/apr-util-1.6.3.tar.gz

Place each of the *.tar.gz files in the `ch-apache` directory.

To build the image, from the root of the repo run:

    docker build -t ch-apache ch-apache/

