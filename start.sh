#!/bin/sh
# https://github.com/long2k3pro/XrayR/releases/download/v0.8.2.2/XrayR-linux-64.zip
# Global variables
XPATH="/usr/local"
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

#Install XrayR
#install -m 755 ${TMP}/gost ${RUNTIME}

#Run XrayR
${XPATH}/xrayr/XrayR -config ${XPATH}/xrayr/config.yml