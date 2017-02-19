# Overview
Shell script that creates a unifed OpenVPN profile based on a user-provided template.

# Warning
Before usage, make sure these lines are either commented out or not present in your sample client ovpn:
```
ca ca.crt
cert client.crt
key client.key
```

# Usage
When run, the script will ask for a few variables:

  1. Name of the client. (To discover the ".key", and ".crt" files.)
  2. Directory of the client's ".key", and ".crt" files. (Default is "/etc/openvpn/easy-rsa/keys/")
  3. Path to server's "ca.crt" file. (Default is "/etc/openvpn/ca.crt")
  4. Path to client template ovpn. (Default is "/etc/openvpn/easy-rsa/keys/client.ovpn")

The script will take your sample client template file and add a few lines to it:
```
ca [inline]
cert [inline]
key [inline]

<ca>
#CONTENTS OF CA FILE#
</ca>

<cert>
#CONTENTS OF CERT FILE#
</cert>

<key>
#CONTENTS OF KEY FILE#
</key>
```
