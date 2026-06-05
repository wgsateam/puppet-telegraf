# Changelog

All notable changes to this project will be documented in this file.

## Release 0.2.0

**Features**

- Update module metadata for Puppet and OpenVox `>= 7.34.0 < 9.0.0`.
- Update supported operating system metadata through CentOS 7, OracleLinux 9, Debian 13, and Ubuntu 26.04.

**Bugfixes**

- Update the `puppetlabs-stdlib` dependency range to match the local project version.
- Add explicit types for all `telegraf` class parameters.
- Replace legacy hostname fact usage with `facts['networking']['hostname']`.
- Fix Puppet lint issues in manifests.

**Known Issues**

## Release 0.1.0

**Features**

**Bugfixes**

**Known Issues**
