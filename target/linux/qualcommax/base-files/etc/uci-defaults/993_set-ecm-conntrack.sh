#!/bin/sh

#指定文件路径
FILE="/etc/sysctl.d/qca-nss-ecm.conf"

#修改最大连接数
sed -i "s/nf_conntrack_max=.*/nf_conntrack_max=65535/g" "$FILE"

# Enable conntrack event extension allocation for ctnetlink subscribers.
if grep -q "^net.netfilter.nf_conntrack_events=" "$FILE"; then
	sed -i "s/^net.netfilter.nf_conntrack_events=.*/net.netfilter.nf_conntrack_events=1/g" "$FILE"
else
	echo "net.netfilter.nf_conntrack_events=1" >> "$FILE"
fi

sysctl -w net.netfilter.nf_conntrack_events=1 >/dev/null 2>&1 || true

exit 0
