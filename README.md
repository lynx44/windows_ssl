windows_ssl Cookbook
====================
This cookbook installs and binds SSL certificates on Windows

e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------

Cookbooks
---------
windows

Resource/Provider
-----------------

import_certificate
------------------

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
------------------

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
