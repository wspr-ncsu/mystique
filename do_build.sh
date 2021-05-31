#!/bin/bash

export PATH="$PATH:/opt/depot_tools"
export DEPOT_TOOLS_UPDATE=0

check_error()
{
	if [ $? -ne 0 ]; then
		exit -1
	fi
}


#
# Prepare the Chromium source tree.
#

CHROMIUM_COMMIT=08caab7e9bdb32c94f9d6dda9a4f147fc0076c93

echo -e "\nChecking out Chromium revision $CHROMIUM_COMMIT...\n"

cd /mnt/chromium/src && git add . -A && \
		git reset --hard HEAD && git checkout $CHROMIUM_COMMIT
check_error

COMMIT_DATE=$(git log -n 1 --pretty=format:%ci)

cd /opt/depot_tools && git add . -A && \
		git reset --hard HEAD && \
		git checkout $(git rev-list -n 1 --before="$COMMIT_DATE" main)
check_error

cd - && git clean -ffd && gclient sync -D --force --reset
check_error

cd v8 && git add . -A && git reset --hard HEAD
check_error
cd -

#
# Apply patches.
#

patch -p1 < /opt/patches/src.patch
check_error

cd v8 && patch -p1 < /opt/patches/src_v8.patch
check_error

cd -

#
# Build.
#

gn gen out/Release
check_error

cp /opt/args.gn out/Release
ninja -C out/Release chrome

