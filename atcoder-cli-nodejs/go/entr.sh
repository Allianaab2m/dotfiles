#!/bin/bash

find ./ -maxdepth 1 -name main.go -or -name input | entr -c ./run.sh
