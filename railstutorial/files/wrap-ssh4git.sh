#!/usr/bin/env bash
/usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/tmp/id_deploy" $1 $2
