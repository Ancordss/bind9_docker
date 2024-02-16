# This Dockerfile builds a custom BIND9 DNS server image.
# It installs the necessary packages, copies the configuration files,
# and exposes the required ports. The DNS server is started using the
# specified command.
FROM internetsystemsconsortium/bind9:9.18



RUN apt update \
    && apt install -y \
    bind9-doc \
    dnsutils \
    geoip-bin \
    mariadb-server \
    net-tools



# Copy configuration files

COPY config/named.conf.options /etc/bind/

COPY config/named.conf.local /etc/bind/

COPY records/db.so2umg.xyz /etc/bind/zones/



# Expose Ports

EXPOSE 53/tcp

EXPOSE 53/udp

EXPOSE 953/tcp



# Start the Name Service

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]