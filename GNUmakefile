include /ioc/tools/driver.makefile

MODULE=ecmccomp

BUILDCLASSES = Linux
EXCLUDE_VERSIONS = 3 7.0.5
ARCH_FILTER=deb%

#SCRIPTS+=startup.cmd

SCRIPTS+=$(wildcard ./motors/*.cmd)
SCRIPTS+=$(wildcard ./scripts/*.cmd)
SCRIPTS+=$(wildcard ./slaves/*.cmd)
SCRIPTS+=$(wildcard ./slaves/hw_sdo_scripts/*.cmd)
SCRIPTS+=$(wildcard ./encoders/*.cmd)

