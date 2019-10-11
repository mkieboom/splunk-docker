# Splunk Enterprise
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Using CentOS 7 as a base image
FROM centos:centos7

MAINTAINER mkieboom

ENV SPLUNK_ADMIN_PASSWORD=adminadmin
ENV SPLUNK_HOME=/opt/splunk
ENV SPLUNK_OFFLOAD_DIR=/splunk_offload/
ENV SPLUNK_IMPORT_NFS_DIR=/splunk_import_nfs/
ENV SPLUNK_IMPORT_VIRTUALINDEX_DIR=/splunk_import_virtualindex/

# Install various prerequisites
RUN yum install -y curl net-tools sudo wget file \
                   which initscripts syslinux openssl && \
    yum -q clean all

# Splunk Download URL
ENV SPLUNK_DOWNLOAD_URL='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.3.2&product=splunk&filename=splunk-7.3.2-c60db69f8e32-linux-2.6-x86_64.rpm&wget=true'

# Download and Install Splunk
RUN wget -O /tmp/splunk.rpm ${SPLUNK_DOWNLOAD_URL} && \
    rpm -i --prefix=/opt/ /tmp/splunk.rpm && \
    rm -rf /tmp/splunk.rpm && \
    yum install -y unzip

# Add the Splunk Apps for Demo Data Generation (eventgen & Cisco)
COPY splunk_apps/eventgen_652.tgz /tmp/eventgen_652.tgz
COPY splunk_apps/cisco-security-suite_312.tgz /tmp/cisco-security-suite_312.tgz

# Expose the Splunk port
EXPOSE 8000

# Add and Run the Install Script
ADD scripts/install.sh /install.sh
RUN sudo chmod +x /install.sh && \
    sudo -E /install.sh

# Add the launch script
ADD scripts/launch.sh /launch.sh
RUN sudo chmod +x /launch.sh
#CMD sudo -E /launch.sh
