#!/bin/bash

MACS=$1
SUPPMACS=$2
CMDFILE=$3

# See that all MACROS are in SUPPMACS
echo "MACS=$MACS"
echo "SUPPMACS=$SUPPMACS"
# Loop throug all macros to see if they are supported
for mac in ${MACS//,/ }
do
  found=0
  for supp in ${SUPPMACS//,/ }
  do
    # Remove all after "="
    mac=${mac%=*}
    if [ "$supp" = "$mac" ]; then  
      found=1
    fi
  done
  if [[ $found -eq 0 ]]; then    
    #echo "Found a non valid macro $mac.."
    echo "ecmcExit Error: Non-valid component macro found for EtherCAT slave \${COMP_S_ID} (\"$mac\")" > $CMDFILE
    exit 1
  fi
done
echo "# All macros valid" > $CMDFILE
