# Script::Ripper

Given a website like https://jellyfin.org/docs/general/administration/installing.html

<img width="730" alt="Screen Shot 2022-09-03 at 6 27 20 PM" src="https://user-images.githubusercontent.com/302063/188293241-8d7c79ac-33d8-418d-9f53-542a090004df.png">


Get a bash script like

```bash
#!/usr/bin/env bash

# https://jellyfin.org/docs/general/administration/installing.html
# Ubuntu

# Remove the old /etc/apt/sources.list.d/jellyfin.list file:
/etc/apt/sources.list.d/jellyfin.list

# Remove the old /etc/apt/sources.list.d/jellyfin.list file:
sudo rm /etc/apt/sources.list.d/jellyfin.list

# Install HTTPS transport for APT if you haven't already:
sudo apt install apt-transport-https

# Enable the Universe repository to obtain all the FFMpeg dependencies:
# If the above command fails you will need to install the following package software-properties-common.
# This can be achieved with the following command sudo apt-get install software-properties-common
sudo add-apt-repository universe

# If the above command fails you will need to install the following package software-properties-common.
# This can be achieved with the following command sudo apt-get install software-properties-common
sudo apt-get install software-properties-common

# Import the GPG signing key (signed by the Jellyfin Team):
curl -fsSL https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian-jellyfin.gpg

# Add a repository configuration at /etc/apt/sources.list.d/jellyfin.list:
/etc/apt/sources.list.d/jellyfin.list

# Add a repository configuration at /etc/apt/sources.list.d/jellyfin.list:
# Supported releases are bionic, cosmic, disco, eoan, and focal.
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list

# Update APT repositories:
sudo apt update

# Install Jellyfin:
sudo apt install jellyfin

# Manage the Jellyfin system service with your tool of choice:
sudo service jellyfin status
sudo systemctl restart jellyfin
sudo /etc/init.d/jellyfin stop

# Enable the Universe repository to obtain all the FFMpeg dependencies, and update repositories:
sudo add-apt-repository universe
sudo apt update

# Install the required dependencies:
sudo apt install at libsqlite3-0 libfontconfig1 libfreetype6 libssl1.0.0

# Install the downloaded .deb packages:
sudo dpkg -i jellyfin_*.deb jellyfin-ffmpeg_*.deb

# Use apt to install any missing dependencies:
sudo apt -f install

# Manage the Jellyfin system service with your tool of choice:
sudo service jellyfin status
sudo systemctl restart jellyfin
sudo /etc/init.d/jellyfin stop
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
