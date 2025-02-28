# *OpenWRT* packages of various *Graphite*-related projects

## Packages

* [go-graphite/go-carbon](https://github.com/go-graphite/go-carbon)
* [go-craphite/carbonapi](https://github.com/go-graphite/carbonapi)
* [grobian/carbon-c-relay](https://github.com/grobian/carbon-c-relay)

## Installation

### Fetch and install signing key

```sh
wget https://roedal.github.io/openwrt-go-graphite/signing-key/481fd63dd3054e01
mv 481fd63dd3054e01 /etc/opkg/key
```

### Configure custom feed

Add feed URL to `/etc/opkg/customfeeds.conf` configuration file. This URL is architecture-specific.

* `aarch64_cortex-a53`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/aarch64_cortex-a53/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `aarch64_cortex-a72`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/aarch64_cortex-a72/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `aarch64_cortex-a76`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/aarch64_cortex-a76/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `aarch64_generic`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/aarch64_generic/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `arm_arm1176jzf-s_vfp`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/arm_arm1176jzf-s_vfp/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `arm_cortex-a7_neon-vfpv4`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/arm_cortex-a7_neon-vfpv4/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `arm_cortex-a8_vfpv3`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/arm_cortex-a8_vfpv3/graphite' >> /etc/opkg/customfeeds.conf
  ```

* `x86_64`

  ```sh
  echo 'src/gz graphite https://roedal.github.io/openwrt-go-graphite/x86_64/graphite' >> /etc/opkg/customfeeds.conf
  ```

### Update package list

```sh
opkg update
```

### Install required package(s)

```sh
opkg install go-carbon carbonapi
```
