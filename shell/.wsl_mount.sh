#!/bin/bash
if ! mountpoint -q ~/04.Kyusandai; then
    sshfs Kyusandai:/home/kato ~/04.Kyusandai/
fi

