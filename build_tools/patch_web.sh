#!/usr/bin/env sh

set -e
# This script is needed to patch the flutter.js and flutter_service_worker.js so they load faster 
# see: https://github.com/dwyl/app/issues/326#issuecomment-1478314967
patch ./build/web/flutter.js < ./build_tools/web/flutter.js.patch
patch ./build/web/flutter_service_worker.js < ./build_tools/web/flutter_service_worker.js.patch