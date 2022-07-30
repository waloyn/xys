#!/bin/sh

# Global variables
XPATH="/usr/local"
GPATH="/usr/bin"
TMP="$(mktemp -d)"

#Get XrayR 
curl --retry 5 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL ${downUrl} -o ${TMP}/xrayr.zip
mkdir ${TMP}/xrayr && unzip -qo ${TMP}/xrayr.zip -d ${TMP}/xrayr
mkdir ${XPATH}/xrayr && cp -r ${TMP}/xrayr/* ${XPATH}/xrayr
chmod 755 ${XPATH}/xrayr/XrayR
sed -i "s/PanelType: \"SSpanel\"/PanelType: ${PanelType}/g" ${XPATH}/xrayr/config.yml
sed -i "s/ApiHost: \"http:\/\/127.0.0.1:667\"/ApiHost: ${ApiHost}/g" ${XPATH}/xrayr/config.yml
sed -i "s/ApiKey: \"123\"/ApiKey: ${ApiKey}/g" ${XPATH}/xrayr/config.yml
sed -i "s/NodeID: 41/NodeID: ${NodeID}/g" ${XPATH}/xrayr/config.yml
sed -i "s/NodeType: V2ray/NodeType: ${NodeType}/g" ${XPATH}/xrayr/config.yml
ln -s ${XPATH}/xrayr /etc/XrayR

#Get Gost
curl --retry 5 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL "https://github.com/go-gost/gost/releases/download/v3.0.0-beta.1/gost-linux-amd64-3.0.0-beta.1.gz" -o ${TMP}/gost.gz
busybox gzip -d ${TMP}/gost.gz

#Install Gost
install -m 755 ${TMP}/gost  ${GPATH}

#Run XrayR
nohup ${XPATH}/xrayr/XrayR -config ${XPATH}/xrayr/config.yml &

#Run Gost
${GPATH}/gost -L tcp://:${PORT}/:10010
