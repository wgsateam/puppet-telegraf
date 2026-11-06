# Changelog

All notable changes to this project will be documented in this file.

## Release 0.3.0

Prepares the generated config for Telegraf 1.37 to 1.41 and stays compatible
with Telegraf 1.36.

**Features**

- Set `skip_processors_after_aggregators = true` in the `[agent]` section.
  Telegraf 1.41 makes this the default, and setting it explicitly silences
  the startup warning. Processors still run once, before aggregators.

**Bugfixes**

- Remove `utc` from the `[agent]` section. Telegraf has ignored it since 1.0
  and removed it in 1.37, which refuses to start when it is set.
- Remove `telegraf::plugin::io` and drop `io` from the default `plugins`
  list. Telegraf removed `inputs.io` in 1.30 and refuses to start with it.
- Update the `puppetlabs-stdlib` dependency to `>= 9.0.0 < 10.0.0`.

**Breaking changes**

- Remove the unused `telegraf::outputs` define. Use `telegraf::plugin` with
  `plugin_name => '[outputs.<name>]'` instead.

**Known Issues**

- `templates/fragment.erb` writes invalid TOML for undef values, for strings
  that contain `'`, for hashes nested more than one level deep and for arrays
  of hashes. Strings that start with `{` are written unquoted. Telegraf
  refuses to start on such a fragment, so keep these out of `conf` or use a
  static file.

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
