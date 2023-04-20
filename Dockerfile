FROM ubuntu:22.04


ARG URL_PREFIX=/qgis


ARG QGIS_SERVER_LOG_LEVEL=1


ADD file:9e2b03572405dc97aff8ac423ad202b0f4aa374427479250ab30c216c05845c4 in /etc/apache2/sites-enabled/qgis-server.conf


QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c sed -i "s!@URL_PREFIX@!$URL_PREFIX!g; s!@QGIS_SERVER_LOG_LEVEL@!$QGIS_SERVER_LOG_LEVEL!g" /etc/apache2/sites-enabled/qgis-server.conf

QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c rm /etc/apache2/sites-enabled/000-default.conf

QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c mkdir /etc/service/apache2

ADD file:60df1d4adc26d4c633df4c8d655de0060de159fc340a359371eec7dd63ffdf19 in /etc/service/apache2/run

QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c chmod +x /etc/service/apache2/run

QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c mkdir /etc/service/dockerlog

ADD file:d9799c06f3844a1976e069a0f8f7dace7d5166bc5b259027c9b1ce95d50cb178 in /etc/service/dockerlog/run

QGIS_REPO=ubuntu QGIS_SERVER_LOG_LEVEL=1 URL_PREFIX=/ows /bin/sh -c chmod +x /etc/service/dockerlog/run

EXPOSE 80

VOLUME [/data]


CMD ["/sbin/my_init","--","setuser","1000980000","bash"]
