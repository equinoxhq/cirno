# Package

version       = "0.1.0"
author        = "xTrayambak"
description   = "A very simple FFlag tracker written in Nim"
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["cirno"]


# Dependencies

requires "nim >= 2.0.0"

requires "chronicles >= 0.10.3"
requires "curly >= 1.1.1"
requires "results >= 0.5.1"
requires "dimscord >= 1.6.0"
requires "jsony >= 1.1.5"
requires "pretty >= 0.2.0"