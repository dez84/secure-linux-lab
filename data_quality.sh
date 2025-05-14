#!/bin/bash
echo "Checking for empty files in /data..."
find /data -type f -size 0
