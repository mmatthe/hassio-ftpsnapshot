# Hassio FTP Backup

This addon does the following:


1. Creates a full snapshot of the Home Assistant configuration via Hass Snapshot functionality. It uses the [Supervisor API](https://github.com/home-assistant/supervisor/blob/dev/API.md#snapshot) to do that.

2. Uploads the created snapshot to an FTP Server

## Installation:
* Install SSH addon or Samba addon (tested with SSH)
* Clone this repository into `/addons/ftpsnapshot`
* Refresh Home Assistant Addon-Store (Supervisor -> Add-on Store -> Refresh button)
* Install the Plugin, which is to be found under "Local add-ons"

## Usage
### Configuration
The addon requires 3 configuration parameters:
- `ftpuser` and `ftppass` denote the credentials used for logging in into the FTP server
- `ftpurl` determines the URL where the backup is to be put. Note that this has **end with a trailing slash** in order to work.

Example YAML:

```yaml
ftpuser: user
ftppass: pass
ftpurl:  'ftp://ip-of-my-NAS/share-name/folder/with/trailing/slash/'
```

For each execution of the addon, one snapshot is created and uploaded to the FTP server. Check the Logs for some status information.

### Automation:
To perform weekly snapshots, create an automation with the following content:

```yaml
- id: '1584285634435'
  alias: Trigger Snapshot creation and uploading to NAS
  description: ''
  trigger:
  - at: '2:00'
    platform: time
  condition:
  - condition: time
    weekday: sun
  action:
  - data:
      addon: local_ftpbackup
    service: hassio.addon_start
```
