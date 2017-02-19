#!/bin/bash

function unify {
cp $clienttemp ${newclientname}.ovpn

cat <<EOF >> ${newclientname}.ovpn

ca [inline]
cert [inline]
key [inline]

<ca>
EOF
cat ${ca} >> ${newclientname}.ovpn
cat <<EOF >> ${newclientname}.ovpn
</ca>
<cert>
EOF
cat ${cert} >> ${newclientname}.ovpn
cat <<EOF >> ${newclientname}.ovpn
</cert>
<key>
EOF
cat ${key} >> ${newclientname}.ovpn
cat <<EOF >> ${newclientname}.ovpn
</key>
EOF
}

read -p "Name of new client: " newclientname
echo
read -e -p "Directory of '${newclientname}.key' and '${newclientname}.crt': " -i "/etc/openvpn/easy-rsa/keys/" newclientdir
echo
read -e -p "Path to server's 'ca.crt' file: " -i "/etc/openvpn/ca.crt" cafile
echo
read -e -p "Path to client template file: " -i "/etc/openvpn/easy-rsa/keys/client.ovpn" clienttemp
echo
if [ -e "$clienttemp" ] && [ -e "$cafile" ] && [ -e "${newclientdir}${newclientname}.crt" ] && [ -e "${newclientdir}${newclientname}.key" ]; then
	echo "Files verified."; echo

	ca=${cafile}
	cert=${newclientdir}${newclientname}.crt
	key=${newclientdir}${newclientname}.key

	while true; do
		read -p "Would you like to unify ${newclientname}'s profile? [y/n] " yn
		case $yn in
			[Yy]*) unify; break;;
			[Nn]*) echo "Operation canceled."; break;;
			*) echo "Please make a choice.";;
		esac
	done
else
	echo "File discovery failed. Please verify your inputs and try again."
fi
