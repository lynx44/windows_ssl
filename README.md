windows_ssl Cookbook
====================
This cookbook installs and binds SSL certificates on Windows

Requirements
------------

- Windows server 2008 R2
- Windows server 2012 
- Windows server 2016 

Cookbooks
---------
windows

Resource/Provider
-----------------

import_certificate
==================

### Actions

:import - imports the certificate into the certificate store

### Attribute Parameters

- path: the path to the certificate
- password: the password for the certificate file
- type: the type of certificate (currently only supports pfx)

### Examples

    windows_ssl_import_certificate "import the ssl cert" do
        path 'c:\certificate.pfx'
        password 'p@ssw0rd'
        type :pfx
        action :import
    end

bind_certificate
================

### Actions

:bind - binds a certificate to a port

### Attribute Parameters

- certificate_hash: the certificate hash
- port: the port
- ip_address: the ip address to bind to. Defaults to 0.0.0.0 (any ip address)
- app_guid: the application guid. Defaults to 00000000-0000-0000-0000-000000000000 (any application)

### Examples

    windows_ssl_bind_certificate "bind the ssl cert" do
        certificate_hash '991deaa340c14b45214927f58a8b7288d9ce6906'
        port 443
        ip_address '0.0.0.0'
        app_guid '1A25F4DE-A3DE-FEA2-EAF0-023FA1AD324'
        action :bind
    end
