#!/bin/bash
echo "`hostname -I |cut -d ' ' -f1,2` `hostname`" > hosts
sudo cp hosts /etc

