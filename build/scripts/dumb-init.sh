#!/bin/sh

cd "${SRCPATH}/dumb-init"
${MUSLGCC} --static -o dumb-init -O2 dumb-init.c
