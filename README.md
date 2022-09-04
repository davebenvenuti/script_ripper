# Script::Ripper

Given a website like https://jellyfin.org/docs/general/administration/installing.html

<img width="730" alt="Screen Shot 2022-09-03 at 6 27 20 PM" src="https://user-images.githubusercontent.com/302063/188293241-8d7c79ac-33d8-418d-9f53-542a090004df.png">


Get a bash script like

```bash
# https://jellyfin.org/docs/general/administration/installing.html

# Download the latest container image.
docker pull jellyfin/jellyfin

# Create persistent storage for configuration and cache data.
# Either create two directories on the host and use bind mounts:
# Or create two persistent volumes:
mkdir /path/to/config
mkdir /path/to/cache
docker volume create jellyfin-config
docker volume create jellyfin-cache
```

## Installation

```bash
gem install script_ripper
```

## Usage

```bash
script_ripper -g h4 "https://jellyfin.org/docs/general/administration/installing.html" "Ubuntu"
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davebenvenuti/script_ripper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
