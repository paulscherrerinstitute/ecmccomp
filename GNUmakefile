include /ioc/tools/driver.makefile

MODULE=ecmccomp

BUILDCLASSES = Linux
EXCLUDE_VERSIONS = 3 7.0.5
ARCH_FILTER=deb%

SCRIPTS+=$(wildcard ./motors/*.cmd)
SCRIPTS+=$(wildcard ./scripts/*.cmd)
SCRIPTS+=$(wildcard ./scripts/support/*.cmd)
SCRIPTS+=$(wildcard ./scripts/support/*.sh)
SCRIPTS+=$(wildcard ./drive_slaves/*.cmd)
SCRIPTS+=$(wildcard ./drive_slaves/hw_sdo_scripts/*.cmd)
SCRIPTS+=$(wildcard ./encoder_slaves/*.cmd)
SCRIPTS+=$(wildcard ./encoder_slaves/hw_sdo_scripts/*.cmd)
SCRIPTS+=$(wildcard ./encoders/*.cmd)
SCRIPTS+=$(wildcard ./ai_slaves/hw_sdo_scripts/*.cmd)
SCRIPTS+=$(wildcard ./ai_slaves/*.cmd)
SCRIPTS+=$(wildcard ./ai/*.cmd)
