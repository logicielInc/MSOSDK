#!/bin/bash
#
# Copy frameworks for app target
#

alias errecho='>&2 echo'

build_phase copy_libraries \
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
