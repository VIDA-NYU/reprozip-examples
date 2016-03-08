#!/usr/bin/env bash

LINES=$(wc -l textfile | cut -d ' ' -f 1)
PAGE_LINES=25
PAGES=$(($LINES / PAGE_LINES))
echo $PAGES
