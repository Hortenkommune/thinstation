FROM docker.io/library/centos:latest

ENV STARTPAGE=https://horten.kommune.no
ENV SMBUSER=USERNAME
ENV SMBPASSWD=PASSWORD
ENV SMBSTRING=SMBSTRING

USER root
RUN yum -y update  \
    && yum -y install bash git wget \
    && yum clean all

RUN wget -O /prepare-ci.sh https://raw.githubusercontent.com/Hortenkommune/thinstation/master/KIOSK_V/prepare-thinstation-container-image.sh
RUN wget -O /build.sh https://raw.githubusercontent.com/Hortenkommune/thinstation/master/KIOSK_V/prepare-thinstation-for-building.sh
RUN chmod +x /prepare-ci.sh
RUN chmod +x /build.sh
RUN /bin/bash /prepare-ci.sh

CMD /bin/bash /build.sh $STARTPAGE