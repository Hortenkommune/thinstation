FROM docker.io/library/centos:latest
RUN yum -y update  \
    && yum -y install bash \
    && yum -y install git \
    && yum -y install wget \
    && yum clean all
RUN wget -O - https://raw.githubusercontent.com/Hortenkommune/thinstation/master/prepare-thinstation-container-image.sh | bash
CMD wget -O - https://raw.githubusercontent.com/Hortenkommune/thinstation/master/prepare-thinstation-for-building.sh | bash