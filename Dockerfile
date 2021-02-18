FROM docker.io/library/centos:latest
USER root
RUN yum -y update  \
    && yum -y install bash git wget \
    && yum clean all
RUN wget -O - https://raw.githubusercontent.com/Hortenkommune/thinstation/beta/prepare-thinstation-container-image.sh | bash
CMD wget -O - https://raw.githubusercontent.com/Hortenkommune/thinstation/beta/prepare-thinstation-for-building.sh | bash
