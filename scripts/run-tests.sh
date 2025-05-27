#!/usr/bin/env sh

bin="racket"
ext=rkt

for file in $(find src -name "lang-*.${ext}"); do
    echo "[run] $file"
    ${bin} $file
done
