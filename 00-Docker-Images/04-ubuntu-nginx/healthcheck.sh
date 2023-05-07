#!/bin/bash

STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost/status.html)

if [ $STATUS -eq 200 ]; then
    exit 0
else
    exit 1
fi