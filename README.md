
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache HTTP Server ModSecurity Alerts Incident
---

An Apache HTTP Server ModSecurity Alerts incident refers to a situation where the ModSecurity module of the Apache web server detects unusual or potentially malicious activity. This module is designed to provide an additional layer of security to the web server by analyzing incoming traffic and blocking any requests that match predefined security rules. When an incident of this type occurs, it indicates that ModSecurity has detected activity that could potentially compromise the security of the web server and its applications. This type of incident requires immediate investigation and remediation to prevent any further damage to the system.

### Parameters
```shell
export PATH_TO_AUDIT_LOG="PLACEHOLDER"

export MODSECURITY_PACKAGE_NAME="PLACEHOLDER"

export APACHE_PACKAGE_NAME="PLACEHOLDER"
```

## Debug

### Check if Apache HTTP Server is running
```shell
systemctl status apache2.service
```

### Check Apache error log for any ModSecurity related errors
```shell
tail -f /var/log/apache2/error.log | grep ModSecurity
```

### Check if ModSecurity module is loaded in Apache
```shell
apachectl -M | grep security
```

### Check ModSecurity configuration file for any syntax errors
```shell
apachectl configtest
```

### Check ModSecurity rule set for any errors
```shell
modsec-srs -T
```

### Check ModSecurity rule set for any false positives
```shell
modsec-srs -F ${PATH_TO_AUDIT_LOG}
```

### Check ModSecurity rule set for any false negatives
```shell
modsec-srs -N ${PATH_TO_AUDIT_LOG}
```

## Repair

### Ensure that the Apache HTTP Server and ModSecurity are up-to-date with the latest patches and versions to address any known vulnerabilities.
```shell


#!/bin/bash

# update the package lists

sudo apt-get update

# upgrade the Apache HTTP Server and ModSecurity packages

sudo apt-get install --only-upgrade ${APACHE_PACKAGE_NAME} ${MODSECURITY_PACKAGE_NAME}

# restart the Apache web server to apply the changes

sudo systemctl restart apache2.service


```