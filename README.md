# zabbix-domain-expiry
Zabbix template to monitor the expiry dates of domain names. This solution downloads whois data then checks expiry date from the whois data. This is a workaround from the solutions currently available which utilize whois utility on linux.

Setup:
1. Copy shell script check_domain.sh to your Zabbix server external scripts dir (default: /usr/lib/zabbix/externalscripts/)
2. Make it executable (e.g. chmod +x /usr/lib/zabbix/externalscripts/check_domain.sh)
3. Import yaml template to your zabbix server
4. Create a host and attach the template to the host. Make sure to add macro {$DOMAINNAME} with domain name as the value.
5. Add this line on zabbix_agentd.conf:
   UserParameter=check_domain[*],/usr/lib/zabbix/externalscripts/check_domain.sh $1

6. restart zabbix-agent

