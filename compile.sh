#! /bin/bash

RELEASE=0
DEBUG_DIRECTORY="./build/debug"
RELEASE_DIRECTORY="./build/release"

usage() { echo "Usage: $0"; echo "-r: will setup cmake release profile and compile a executable in the build/release folder." 1>&2; exit 1; }

# Check for build options
while getopts "rd" opt; do
  case "${opt}" in
    r)
      RELEASE=1
      echo "Release build selected";
      ;;
    d)
      RELEASE=0
      echo "Debug build selected";
      ;;
    *)
      usage
      ;;
  esac
done


if [[ ! -d "$DEBUG_DIRECTORY" && ($RELEASE == 0)]]; then
  echo "The CMake debug preset does not exist creating one now."
  cmake --preset compile-debug
fi

if [[ ! -d "$RELEASE_DIRECTORY" && ($RELEASE == 1)]]; then
  echo "The CMake release preset does not exist creating one now."
  cmake --preset compile-release
fi

# Depending on the value of RELEASE select the debug or release build
if [[($RELEASE == 0)]]; then
  cmake --build build/debug
elif [[( $RELEASE == 1)]]; then
  cmake --build build/release
fi

echo "CMake build complete!"