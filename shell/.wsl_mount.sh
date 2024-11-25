#!/bin/bash
if ! mountpoint -q ~/04.Kyusandai; then
    sshfs -o transform_symlinks Kyusandai:/home/kato /home/kato/04.Kyusandai
fi

