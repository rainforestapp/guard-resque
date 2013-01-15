[![Build Status](https://travis-ci.org/rainforestapp/guard-resque.png?branch=master)](https://travis-ci.org/rainforestapp/guard-resque)

[![Dependency Status](https://gemnasium.com/rainforestapp/guard-resque.png)](https://gemnasium.com/rainforestapp/guard-resque)


# Guard::Resque

Guard::Resque automatically starts/stops/restarts resque workers

*Forked from [Guard::Resque](http://github.com/railsjedi/guard-resque)*

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before you continue.

Install the gem:

```bash
gem install guard-resque
```

Add it to your Gemfile (inside test group):

```bash
gem 'guard-resque'
```

Add guard definition to your Guardfile by running this command:

```bash
guard init resque
```

## Usage

Please read Guards [usage documents](http://github.com/guard/guard#readme).

I suggest you put the resque guard definition *before* your test/rspec guard if your tests depend on it being active.

### Guardfile

```ruby
guard 'resque', :environment => 'development' do
  watch(%r{^app/(.+)\.rb$})
  watch(%r{^lib/(.+)\.rb$})
end
```

Feel free to be more specific, for example watching only for `app/models` and `app/jobs` to avoid reloading on a javascript file change.

### Options

You can customize the resque task via the following options:

* `environment`: the rails environment to run the workers in (defaults to `nil`)
* `task`: the name of the rake task to use (defaults to `"resque:work"`)
* `queue`: the resque queue to run (defaults to `"*"`)
* `interval`: the interval to use for checking for new resque jobs (defaults to `5`)
* `count`: the number of workers to include (defaults to `1`)
* `verbose`: whether to use verbose logging (defaults to `nil`)
* `vverbose`: whether to use very verbose logging (defaults to `nil`)
* `trace`: whether to include `--trace` on the rake command (defaults to `nil`)
* `stop_signal`: how to kill the process when restarting (defaults to `SIGTERM`)
* `stop_timeout`: how long to wait (in seconds) for resque to exit (defaults to 5 seconds, one more than the resque default)
* `term_child`: defaults to 1 to use the new signal handling in 2.x


## Development

 * Source hosted at [GitHub](http://github.com/ukd1/guard-resque)
 * Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/ukd1/guard-resque/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change you make.

### Testing the gem locally

```bash
gem install guard-resque-0.x.x.gem
```

### Building and deploying gem

 * Update the version number in `lib/guard/resque/version.rb`
 * Update `CHANGELOG.md`
 * Build the gem:

```bash
gem build guard-resque.gemspec
```

 * Push to rubygems.org:

```bash
gem push guard-resque-0.x.x.gem
```


### Guard::Delayed Authors

  * [David Parry](https://github.com/suranyami)
  * [Dennis Reimann](https://github.com/dbloete)

Ideas for this gem came from [Guard::WEBrick](http://github.com/fnichol/guard-webrick).


### Guard::Resque Authors

[Jacques Crocker](https://github.com/railsjedi) hacked this together from the `guard-delayed` gem for use with Resque. All credit go to the original authors though. Jacques just search/replaced and tweaked a few things.

I've ([ukd1](https://github.com/ukd1)) only fixed a few issues that have cropped up recently that were annoying and unfixed.