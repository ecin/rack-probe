Rack::Probe : dtrace probes for your webapp
===========================================

status
------

Rack::Probe (along with Dtracy) is part of the Ruby on Rail's Google Summer of Code '09 Quartet, with development updates and entertainment available at `http://ecin.tumblr.com` Welcome! Sit down, grab a sugary drink, and enjoy the smell of freshly baked code right out of the oven.

requirements
------------

An operating system with support for Dtrace (http://www.sun.com/bigadmin/content/dtrace/) is a must. Mac OS X, Solaris/OpenSolaris and FreeBSD are all acceptable choices, though no testing has been done on FreeBSD.

gem dependencies
------------

* rack
* ruby-dtrace

installing
----------

`gem sources -a http://gems.github.com`
`gem install ecin-rack-probe`

setup
-----

Rails Middleware:

_Inside your config/environment.rb_

`config.gem "ecin-rack-probe", :lib => "rack/probe"`
`config.middleware.use "Rack::Probe"`

Rack Middleware:

_Inside your rackup file_

`require 'rack/probe'`
`use Rack::Probe`

use
---

From a terminal, run `dtrace -n rack*::: -l` to get a list of all the available probes. The number you'll see after 'rack' in the provider field is the PID of the process that's making the probes available.

copyright
---------

Copyright (c) 2009 ecin. See LICENSE for details.