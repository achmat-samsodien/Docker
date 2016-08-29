FROM dockerhub.interfront.local:5000/centos

MAINTAINER Interfront

RUN     yum update ; \
        yum install -y unzip glibc.i686 libgcc.i686 curl wget openssh ; \
        yum clean all

VOLUME "/tmp"


######################### IBM Installation Manager ########################

RUN     mkdir -p /tmp/IIM ; \
        wget http://ict-repo.interfront.local/bakery/binary_content/websphere/WAS_ND_V8.5.5_Installation_Manager/InstalMgr1.6.2_LNX_X86_WAS_8.5.5.zip -O /tmp/IIM/InstalMgr1.6.2_LNX_X86_WAS_8.5.5.zip ; \
        cd /tmp/IIM ; \
        unzip -q InstalMgr1.6.2_LNX_X86_WAS_8.5.5.zip ; \
        rm -rf InstalMgr1.6.2_LNX_X86_WAS_8.5.5.zip ; \
        ./install --launcher.ini silent-install.ini -acceptLicense ; \
        rm -rf /tmp/*


COPY ./files/install_WAS85.rsp /tmp/WAS/install_WAS85.rsp

############# IBM WebSphere Application Server Network Deployment #########

RUN     mkdir -p /tmp/WAS ; \
        curl -o /tmp/WAS/WAS_ND_V8.5.5_Application_Server.zip http://ict-repo.interfront.local/bakery/binary_content/websphere/WAS_ND_V8.5.5_Application_Server/WAS_ND_V8.5.5_Application_Server.zip ; \
        cd /tmp/WAS ; \
        unzip -q WAS_ND_V8.5.5_Application_Server.zip ; \
        rm -rf WAS_ND_V8.5.5_Application_Server.zip ; \
        /opt/IBM/InstallationManager/eclipse/IBMIM -input install_WAS85.rsp -log install_WAS85.log -silent -nosplash -acceptLicense ; \
        mkdir -p /tmp/was_java ; \
        cd /tmp ; \
        curl -o /tmp/was_java/java7.rsp http://ict-repo.interfront.local/bakery/binary_content/websphere_java7/java7.rsp ; \
        curl -o /tmp/was_java/WS_SDK_JAVA_TEV7.0_WAS_8.5.5.zip http://ict-repo.interfront.local/bakery/binary_content/websphere_java7/WS_SDK_JAVA_TEV7.0_WAS_8.5.5.zip ; \
        cd /tmp/was_java/ ; \
        unzip -q WS_SDK_JAVA_TEV7.0_WAS_8.5.5.zip ; \
        rm -rf WS_SDK_JAVA_TEV7.0_WAS_8.5.5.zip ; \
        /opt/IBM/InstallationManager/eclipse/IBMIM -input /tmp/was_java/java7.rsp -log install_java7.log -nosplash -acceptLicense -silent ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -listAvailable ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -setCommandDefault -sdkname 1.7_64 ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -setNewProfileDefault -sdkname 1.7_64 ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -enableProfileAll -sdkname 1.7_64 -enableServers -user admin -password admin ; \
        rm -rf /tmp/*

###### IBM WebSphere Application Server Network Deployment Fixpack #######

RUN     mkdir -p /tmp/WAS_Fixpacks ; \
        curl -o /tmp/WAS_Fixpacks/WAS_NAD_V8.5.5_Fixpack8.zip http://ict-repo.interfront.local/bakery/binary_content/websphere/WAS_NAD_V8.5.5_Fixpack8/8.5.5-WS-WAS-Fixpack8.zip ; \
        cd /tmp/WAS_Fixpacks ; \
        unzip -q WAS_NAD_V8.5.5_Fixpack8.zip ; \
        rm -rf /tmp/WAS_Fixpacks/WAS_NAD_V8.5.5_Fixpack8.zip ; \
        /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.websphere.ND.v85 -installationDirectory /opt/IBM/WebSphere/AppServer/ -repositories /tmp/WAS_Fixpacks/ -acceptLicense ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -listAvailable ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -setCommandDefault -sdkname 1.7_64 ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -setNewProfileDefault -sdkname 1.7_64 ; \
        /opt/IBM/WebSphere/AppServer/bin/managesdk.sh -enableProfileAll -sdkname 1.7_64 -enableServers -user admin -password admin ; \
        rm -rf /tmp/*

######### Expose WAS Ports ###################


EXPOSE 2809 9402 9403 9353 9633 9100 11004 11003 9401 7276 7286 5558 5578 5060 5061 8880 9060 9043 9080 9443

