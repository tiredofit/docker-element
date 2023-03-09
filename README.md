# github.com/tiredofit/element

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/element?style=flat-square)](https://github.com/tiredofit/element/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-element/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-element/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/element.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/element/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/element.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/element/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker Image for [Element](https://element.io), An Instant Messenger application to connect to Matrix Homeservers.

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Container Options](#container-options)
    - [Application Options](#application-options)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)


## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/element)

```bash
docker pull docker.io/tiredofdit/element:(imagetag)
```
Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/docker-element/pkgs/container/docker-element)

```
docker pull ghcr.io/tiredofit/docker-element:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description         |
| --------- | ------------------- |
| `/config` | Configuration Files |

* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)    | Nginx webserver                        |

#### Container Options

| Variable      | Description                                           | Default       |
| ------------- | ----------------------------------------------------- | ------------- |
| `CONFIG_FILE` | Config File                                           | `config.json` |
| `CONFIG_PATH` | Config Path                                           | `/config/`    |
| `SETUP_MODE`  | Generate configuration based on environment variables | `AUTO`        |

#### Application Options

| Variable                             | Description | Default                                                                     |
| ------------------------------------ | ----------- | --------------------------------------------------------------------------- |
| `BRAND`                              |             | `Element`                                                                   |
| `BUG_REPORT_URL`                     |             | `https://element.io/bugreports/submit`                                      |
| `CALL_BRAND`                         |             | `Element Call`                                                              |
| `CALL_EXCLUSIVE`                     |             | `false`                                                                     |
| `CALL_URL`                           |             | `https://call.element.io`                                                   |
| `CALL_USER_LIMIT`                    |             | `99`                                                                        |
| `DEFAULT_COUNTRY_CODE`               |             | `US`                                                                        |
| `DEFAULT_DEVICE_DISPLAY_NAME`        |             | `tiredofit`                                                                 |
| `DEFAULT_ENABLE_BREADCRUMBS`         |             | `TRUE`                                                                      |
| `DEFAULT_ROOM_FEDERATE`              |             | `TRUE`                                                                      |
| `DEFAULT_SHOW_POLLS_BUTTON`          |             | `FALSE`                                                                     |
| `DEFAULT_SHOW_STICKERS_BUTTON`       |             | `FALSE`                                                                     |
| `DEFAULT_SHOW_WELCOME_CHECKLIST`     |             | `TRUE`                                                                      |
| `DEFAULT_THEME`                      |             | `light`                                                                     |
| `ENABLE_3PID_LOGIN`                  |             | `FALSE`                                                                     |
| `ENABLE_3PID_SERVICES`               |             | `TRUE`                                                                      |
| `ENABLE_ADVANCED_ENCRYPTION`         |             | `TRUE`                                                                      |
| `ENABLE_ADVANCED_SETTINGS`           |             | `TRUE`                                                                      |
| `ENABLE_CUSTOM_HOME_SERVER_URL`      |             | `TRUE`                                                                      |
| `ENABLE_DEACTIVATE_ACCOUNT`          |             | `TRUE`                                                                      |
| `ENABLE_FEEDBACK`                    |             | `TRUE`                                                                      |
| `ENABLE_FLAIR`                       |             | `TRUE`                                                                      |
| `ENABLE_GUESTS`                      |             | `FALSE`                                                                     |
| `ENABLE_IDENTITY_SERVICES`           |             | `TRUE`                                                                      |
| `ENABLE_LOGIN_LANGUAGE_SELECTION`    |             | `FALSE`                                                                     |
| `ENABLE_REGISTRATION`                |             | `TRUE`                                                                      |
| `ENABLE_RELATIVE_DATES`              |             | `TRUE`                                                                      |
| `ENABLE_ROOM_HISTORY_SETTINGS`       |             | `TRUE`                                                                      |
| `ENABLE_SHARE_QR`                    |             | `TRUE`                                                                      |
| `ENABLE_SHARE_SOCIAL`                |             | `TRUE`                                                                      |
| `ENABLE_UNVERIFIED_SESSION_REMINDER` |             | `TRUE`                                                                      |
| `ENABLE_URL_PREVIEW`                 |             | `TRUE`                                                                      |
| `ENABLE_VOIP`                        |             | `TRUE`                                                                      |
| `ENABLE_WIDGETS`                     |             | `TRUE`                                                                      |
| `HOME_SERVER_URL`                    |             | `https://matrix-client.matrix.org`                                          |
| `IDENTITY_SERVER_URL`                |             | `https://vector.im`                                                         |
| `INTEGRATIONS_REST_URL`              |             | `https://scalar.vector.im/api`                                              |
| `INTEGRATIONS_UI_URL`                |             | `https://scalar.vector.im/`                                                 |
| `JITSI_DOMAIN`                       |             | `meet.element.io`                                                           |
| `JITSI_SKIP_WELCOME_SCREEN`          |             | `TRUE`                                                                      |
| `LOGOUT_REDIRECT_URL`                |             | `null`                                                                      |
| `MAP_STYLE_URL`                      |             | `https://api.maptiler.com/maps/streets/style.json?key=fU3vlMsMn4Jb6dnEIFsx` |
| `SETTINGS_SHOW_LABS`                 |             | `TRUE`                                                                      |
| `SSO_AUTO_LOGIN`                     |             | `FALSE`                                                                     |
| `VOIP_OBEY_ASSERTED_IDENTITY`        |             | `FALSE`                                                                     |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* <https://element.io>
