# Various *OpenWRT* packages of *Graphite*-related projects

> [!IMPORTANT]
> The only supported *OpenWRT* version is **24.10**.

## Packages

* [go-graphite/go-carbon](https://github.com/go-graphite/go-carbon)
* [go-graphite/carbonapi](https://github.com/go-graphite/carbonapi)
* [grobian/carbon-c-relay](https://github.com/grobian/carbon-c-relay)

  Three variants:

  * `carbon-c-relay-full`
  * `carbon-c-relay-nossl`
  * **`carbon-c-relay-tiny`**

* [grafana/carbon-relay-ng](https://github.com/grafana/carbon-relay-ng)
* [atlassian/gostatsd](https://github.com/atlassian/gostatsd)
* `collectd-statsd`

  *StatsD* server created from *CollectD* with *StatD* plugin.
  For simple scenarios this approach may be more efficient than heavy `gostatsd` daemon.

* [grafana/grafana](https://github.com/grafana/grafana)

  [Grafana](https://grafana.com) packages are created from the official [Standalone Linux Binaries](https://grafana.com/grafana/download?edition=oss&platform=linux).
  
  Supported architectures: `x86_64`, `aarch64`, `armv7` and `armv6`.

## Installation

### Download and run [installation script](https://github.com/RoEdAl/graphite-feed/blob/main/openwrt/graphite-feed.sh)

```sh
wget -qO - https://roedal.github.io/graphite-feed/graphite-feed.sh | sh
```

### Update package list

```sh
$ opkg update
Downloading https://roedal.github.io/graphite-feed/aarch64_generic/graphite/Packages.gz
Updated list of available packages in /var/opkg-lists/graphite
Downloading https://roedal.github.io/graphite-feed/aarch64_generic/graphite/Packages.sig
Signature check passed.
⋯
```

### Install required package(s)

```sh
opkg install go-carbon carbonapi carbon-c-relay-tiny
```

> [!IMPORTANT]
> All services are **disabled** by default.
> To enable specific service change `enable` flag to `1` in relevant configuration file from `/etc/config` directory.
>
> ```sh
> uci set go-carbon.main.enable=1
> uci commit
> service go-carbon restart
> ```
