# zabbix-domain-expiry
Zabbix template to monitor the expiry dates of domain names

Setup:
1. Copy shell script check_domain.sh to your Zabbix server external scripts dir (default: /usr/lib/zabbix/externalscripts/)
2. Make it executable (e.g. chmod +x /usr/lib/zabbix/externalscripts/check_domain.sh)
3. Import yaml template to your zabbix server
4. Create a host and attach the template to the host. Make sure to add macro {$DOMAINNAME} with domain name as the value.
