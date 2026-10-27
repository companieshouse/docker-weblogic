This certs folder is the location to place any additional x509 certificates that you wish to be added to the CA trust store during the image build.  

In the CH environment, any additional certificates will be placed in the certs folder as part of the Concourse pipeline that builds the image.

As the JDK is installed as a package, under Oracle Linux, the normal JAVA_HOME/lib/security/cacerts file is actually a link to the OS cacerts file, so any certificates added will be trusted by the OS too.
