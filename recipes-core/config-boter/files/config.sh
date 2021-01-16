rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
echo 'search t-l.ch' > /etc/resolv.conf
echo 'nameserver 10.6.10.10' >> /etc/resolv.conf
echo 'nameserver10.6.10.9' >> /etc/resolv.conf

. /opt/config/boemb.cfg
sn=`ethtool -P eth0  | cut -d " " -f 3`
config=`timeout --foreground 2s mosquitto_sub -h tara.t-l.ch -C 1 -t TL/BOTER/$sn/config`
if [ "x$config" != "x" ]; then
  ip=`echo $config | jq '.IP' | tr --delete \"`
  name=`echo $config | jq '.NAME' | tr --delete \"`

  echo $name > /etc/hostname

  echo "URL=http://127.0.0.1/player/#/boemb/landscape/standard" > /opt/config/boemb.cfg
  echo "IP=$ip" >> /opt/config/boemb.cfg
  echo "NAME=$name" >> /opt/config/boemb.cfg
  echo "Screen_L=1920" >> /opt/config/boemb.cfg
  echo "Screen_H=630" >> /opt/config/boemb.cfg

  sed -i "s/.*address.10.*/  address $ip/" /etc/network/interfaces

  sleep 1

  if [ "$ip" != "$IP" ] || [ "$name" != "$NAME" ]; then
	/sbin/reboot
  fi

else
  sleep 20
  sn=`ethtool -P eth0  | cut -d " " -f 3`
  config=`timeout --foreground 2s mosquitto_sub -h tara.t-l.ch -C 1 -t TL/BOTER/$sn/config`
  if [ "x$config" == "x" ]; then
    echo "<h1>Hardware ID : $sn</h1>" > /usr/share/apache2/htdocs/hardware-id.html
    echo "URL=http://127.0.0.1/hardware-id.html" > /opt/config/boemb.cfg
    echo "Screen_L=1920" >> /opt/config/boemb.cfg
    echo "Screen_H=630" >> /opt/config/boemb.cfg
    echo "IP=10.6.19.253" >> /opt/config/boemb.cfg
    echo "NAME=BIV-9999" >> /opt/config/boemb.cfg
    cd /var/log
    /usr/bin/nohup /opt/scripts/waitconfig.sh &
  fi
fi
