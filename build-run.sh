#!/bin/bash
if [[ -f petsciiart.prg ]]; then
  rm petsciiart.prg
fi

# Build the object
java -jar ../../KickAss.jar petsciiart.asm

if [[ -f petsciiart.prg ]]; then
  x64 petsciiart.prg
fi
