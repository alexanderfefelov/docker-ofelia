#!/usr/bin/env bash

echo
echo "--- Java"
java -version

echo
echo "--- Lua"
lua -v

echo
echo "--- JavaScript (provided by GraalVM)"
js --version

echo
echo "--- Node.js (provided by GraalVM)"
node --version

echo
echo "--- Python"
echo "import sys; print(sys.version)" | python3

echo
echo "--- Python (provided by GraalVM)"
graalpython --version

echo
echo "--- R (provided by GraalVM)"
R --version | head

echo
echo "--- Ruby (provided by GraalVM)"
ruby --version

echo
echo "--- Tcl"
echo "puts [info patchlevel]" | tclsh

echo

exec "$@"
