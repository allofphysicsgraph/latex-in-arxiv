#!/usr/bin/bash
grep -oP '\$[^\$]{1,80}\$' "$1"

