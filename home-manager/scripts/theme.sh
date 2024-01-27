#!/bin/sh

if [ "$(date +%H)" -ge 18 ] || [ "$(date +%H)" -lt 06 ]; then
	THEME="dark"
else
	THEME="light"
fi

echo "$THEME"
