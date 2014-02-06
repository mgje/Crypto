#!/bin/sh
coffee -o js/  -cw coffee/ &
jekyll serve --watch