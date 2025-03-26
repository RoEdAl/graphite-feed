#!/bin/bash

set -e

replace_mod() {
    cd "$BUILD_DIR"
    go work init .
    go work edit -replace github.com/grafana/metrictank=github.com/RoEdAl/metrictank@v1.2.0-arch32
}

replace_mod
