#!/bin/bash
#
# Copy frameworks for test target
#

build_phase copy_libraries --test \
  AFNetworking

case "$SWIFT_PLATFORM_TARGET_PREFIX" in
	macosx);;
	tvos);;
  ios);;
	watchos);;
	*)
		errecho "error: Invalid target platform $SWIFT_PLATFORM_TARGET_PREFIX"
		exit 1
		;;
esac
