+++
title = "API Driven"
type = "docs"
description = "Administration and setting manipulation with the Bottlerocket API" 
+++

Bottlerocket is an API-driven operating system.
This is a departure from general purpose Linux distributions where you install packages, configure services through individual configuration files, and use commands from the shell to perform administrative tasks.

With the concept of variants, all installed software for any given image is a known quantity and an included API enables you to configure everything from a single interface.
Additionally, administrative tasks like checking for updates and rebooting as well as executing commands on the host are all accomplished with API calls.

## Accessing the API

Bottlerocket API requests are made with HTTP requests over a Unix domain socket.
The API is only accessible by containers running on the same host with specific SELinux labels.
The API Unix domain socket is accessible by mounting; containers running on the host can access the API as long as they have both the correct SELinux labels and mount the socket.
Both the Admin and Control containers have the requisite SELinux labels and socket pre-mounted.
Because access to the API socket is through explicit mounts and SELinux labels there is no authentication required.
Consequently, any remote access to the API necessitates an authenticated transport mechanism.

## API Client

Bottlerocket ships with a tool called `apiclient` which provides a command line interface for interacting with the API.
The client is a minimal abstraction over the API: it accepts command-line arguments, translates the arguments into an API call, and returns the response as standard output.
Access to the `apiclient` binary is typically provided as a read-only mount from the host to containers that need access.

## Settings

You can view and alter Bottlerocket settings through the API.
The API is able to `set` or `get`  one or many *settings*.
A setting is accessible by a path and contains a value.

Take this `set` example that alters a single setting:

```goat
          +-- Path            Value
          |                     |
+---------+---------+         +-+-+  
|                   |         |   |
host-containers.admin.enabled=false 
                      |     |
                      +--+--+
                         |
                      Setting
```

If you `get` a path without the setting, it returns all the settings and values in the path:

```goat
          +-- Path
          |
+---------+---------+ 
|                   | 
host-containers.admin --> Values of: 
                             enabled
                             source
                             superpowered
```

If you `get` a path and a setting, it returns only the value of that specific setting:

```goat
          +-- Path
          |
+---------+---------+
|                   | 
host-containers.admin.enabled --> Value of: 
                      |     |        enabled   
                      +--+--+
                         |
                      Setting
```

Internally, these settings are either marshalled into various config formats for each related process or they are directly accessed by Bottlerocket’s own tools.

From the API client, you can either pass in settings in a key/value (format with the key being the path) or as JSON containing both the path and value(s).

As an example:

```shell
host-containers.admin.enabled=false
```

The above key/value format is equivalent to:

```json
{ "host-containers" : { "admin" : { "enabled": false } } }
```

### User Data

User Data is a collection of settings contained in a TOML-formatted file that is processed by the API at boot: anything you can manipulate using `apiclient` you can also manipulate with User Data.

{{< on-github >}}
