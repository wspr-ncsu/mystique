#!/bin/bash

CHROMIUM_SRC_DIR=/run/media/super/edbe9721-9a0c-40d9-ad10-9e5ced5753d1/chromium

docker run --rm -v "$CHROMIUM_SRC_DIR":/mnt/chromium \
		--name chromium -it chromium:dockerfile $*

