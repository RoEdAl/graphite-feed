#!/bin/sh

readonly FEEDS_URL=https://roedal.github.io/graphite-feed

echoerr() {
  echo "$@" | logger -st graphite-feed
}

get_distrib_arch() {
  . /etc/openwrt_release
  echo "$DISTRIB_ARCH"
}

test_feed() {
  wget -qO /dev/null "$1/packages.adb"
}

if [ ! -s /etc/openwrt_release ]; then
  echoerr Error - not OpenWRT OS
  exit 1
fi

ARCH=$(get_distrib_arch)
if [ -z "$ARCH" ]; then
  echoerr Error - unable to read architecture
  exit 1
fi
echoerr Architecture: $ARCH

readonly FEED_URL="$FEEDS_URL/$ARCH/graphite"
if ! test_feed "$FEED_URL"; then
  echoerr Error - invalid feed URL: $FEED_URL
  exit 1
fi

eadonly REPO_LIST=/etc/apk/repositories.d/graphite.list
if [ ! -s "$REPO_LIST" ]; then
  echoerr Installing repository: $FEED_URL
  echo "$FEED_URL/packages.adb" > $REPO_LIST
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi

readonly SIGNING_KEY="/etc/apk/keys/graphite.pem"
if [ ! -s "$SIGNING_KEY" ]; then
  echoerr Installing signing key
  if ! wget -qO $SIGNING_KEY "$FEEDS_URL/signing-key/graphite.pem"; then
    exit 1
  fi
fi

echoerr Done
exit 0
