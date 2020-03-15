#!/usr/bin/env bashio

FTPUSER=$(bashio::config 'ftpuser')
FTPPASS=$(bashio::config 'ftppass')
FTPURL=$(bashio::config 'ftpurl')

echo "Pinging Supervisor..."
curl -s -X GET -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" -H "Content-Type: application/json" http://supervisor/supervisor/ping | jq
echo "Available Snapshots:"
curl -s -X GET -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" -H "Content-Type: application/json" http://supervisor/snapshots | jq
echo "Creating full snapshot..."
slug=$(curl -s -X POST -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" -H "Content-Type: application/json" http://supervisor/snapshots/new/full | jq --raw-output .data.slug)

echo Snapshot /backup/$slug.tar created
echo Uploading snapshot to FTP server
curl -T /backup/${slug}.tar -u ${FTPUSER}:${FTPPASS} ${FTPURL}
