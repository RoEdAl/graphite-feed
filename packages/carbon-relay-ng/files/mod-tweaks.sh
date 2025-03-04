#!/bin/bash

replace_mod() {
    cd "$BUILD_DIR" || return 1
    go mod edit -replace github.com/grafana/metrictank=github.com/RoEdAl/metrictank@v1.2.0-arch32 || return 1
    go get github.com/grafana/carbon-relay-ng/cfg github.com/grafana/carbon-relay-ng/route || return 1
}

replace_mod
