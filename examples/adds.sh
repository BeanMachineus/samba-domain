docker stop samba-dc
docker rm samba-dc
docker run -d \
    --network ExtNet \
    --ip 192.168.71.56 \
    -e "DOMAIN=DOMAINTEST.LOC" \
    -e "DOMAIN_DC=dc=DOMAINTEST,dc=LOC" \
    -e "DOMAIN_EMAIL=domaintest.loc" \
    -e "DOMAINPASS=P@ssw0rd" \
    -e "DNSFORWARDER=192.168.68.1" \
    -e "HOSTIP=192.168.71.56" \
    -e "FUNCTIONLEVEL=2016" \
    -v /etc/localtime:/etc/localtime:ro \
    -v /data/domain/samba/samba-var/:/var/lib/samba \
    -v /data/domain/samba/external:/etc/samba/external \
    --dns-search domaintest.loc \
    --dns 192.168.71.56 \
    --add-host "samba-dc.domaintest.loc samba-dc":192.168.71.56 \
    --hostname samba-dc.domaintest.loc \
    --name samba-dc \
    --restart unless-stopped \
    --privileged \
    ghcr.io/beanmachineus/samba-domain:dev
