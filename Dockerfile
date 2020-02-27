FROM centos:centos7.7.1908
EXPOSE 135 137/udp 138/udp 139 389 389/udp 445 464 636 3268 3269
WORKDIR \root\app\samba
RUN yum update -y \
    && yum groups -y install "Development Tools" \
    && yum -y install iniparser libldb libtalloc libtdb libtevent python-devel gnutls-devel libacl-devel openldap-devel pam-devel readline-devel krb5-devel cups-devel \
    && curl -O https://download.samba.org/pub/samba/stable/samba-4.8.3.tar.gz \
    && tar zxvf samba-4.8.3.tar.gz \
    && cd samba-4.8.3
RUN ./configure \
    --prefix=/usr \
    --localstatedir=/var \
    --with-configdir=/etc/samba \
    --libdir=/usr/lib64 \
    --with-modulesdir=/usr/lib64/samba \
    --with-pammodulesdir=/lib64/security \
    --with-lockdir=/var/lib/samba \
    --with-logfilebase=/var/log/samba \
    --with-piddir=/run/samba \
    --with-privatedir=/etc/samba \
    --enable-cups \
    --with-acl-support \
    --with-ads \
    --with-automount \
    --enable-fhs \
    --with-pam \
    --with-quotas \
    --with-shared-modules=idmap_rid,idmap_ad,idmap_hash,idmap_adex \
    --with-syslog \
    --with-utmp \
    --with-dnsupdate
RUN make \
    && make install
