#!/bin/bash
if ! mountpoint -q ~/05.Yamadai; then
    sshfs -o transform_symlinks Yamadai:/home/katoy /home/kato/05.Yamadai
fi
if ! mountpoint -q ~/04.Kyusandai; then
    sshfs -o transform_symlinks Kyusandai:/home/kato /home/kato/04.Kyusandai
fi

