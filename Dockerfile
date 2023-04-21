FROM ubuntu:22.04

RUN useradd -ms /bin/bash myuser

COPY my_init.py /sbin/my_init

RUN chmod +x ./sbin/my_init

#ADD file:a7268f82a86219801950401c224cabbdd83ef510a7c71396b25f70c2639ae4fa in /etc/apache2/sites-enabled/qgis-server.conf

ADD /api-gateway/nginx-example.conf /etc/apache2/sites-enabled/qgis-server.conf

CMD ["bash"]


ARG QEMU_ARCH

COPY cleanup.sh ./cleanup.sh

COPY buildconfig ./buildconfig

RUN chmod +x ./buildconfig

RUN chmod +x ./cleanup.sh

RUN /bin/sh -c ./cleanup.sh


#RUN |1 QEMU_ARCH= /bin/sh -c /bd_build/prepare.sh && /bd_build/system_services.sh && /bd_build/utilities.sh && /bd_build/cleanup.sh 


ENV DEBIAN_FRONTEND=teletype LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

#RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Set the environment variables for the locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

MAINTAINER Pirmin Kalberer


ARG QGIS_REPO=ubuntu


RUN apt-get update && apt-get install -y curl gpg && apt-get install -y fontconfig fonts-dejavu ttf-bitstream-vera fonts-liberation fonts-ubuntu && apt-get install -y xvfb && apt-get install -y apache2 libapache2-mod-fcgid && curl -L https://qgis.org/downloads/qgis-2022.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import && chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg && echo "deb https://qgis.org/$QGIS_REPO jammy main" > /etc/apt/sources.list.d/qgis.org.list && apt-get update && apt-get install -y qgis-server && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y runit locales

#ADD file:fb8cfc66a2cbdf9d869d8b6ad1fcd9a64199a9faebfddd2dfef06ab20eac5c82 in /usr/share/fonts/truetype/


RUN   /bin/sh -c fc-cache -f && fc-list | sort

    
#RUN   mkdir /etc/service/xvfb
# Set the user for the following CMD instruction '
USER myuser 

# Use the my_init.sh script as the entrypoint 
ENTRYPOINT ["/sbin/my_init"] 

# Run the "bash" shell as user "myuser" 
CMD ["bash"]



