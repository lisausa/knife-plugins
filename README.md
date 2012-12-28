# Lisausa Knife Plugins

These are plugins for the Chef utility `knife`, for use by LISAUSA employees

## Installation

Add this line to your application's Gemfile:

    gem 'lisausa-knife-plugins', github: 'lisausa/lisausa-knife-plugins'

And then execute:

    $ bundle

## Usage

### .ssh/config

    knife setup ssh

This is a plugin for Knife that helps grab all nodes within the LISA cloud and presents you with
a chunk of .ssh/config that provides host name mapping. This has the bonus of allowing for tab
completion, as well.

Take the given chunk of `.ssh/config` and copy-and-paste it into your `~/.ssh/config` file.

It's also useful to add something like this, so you wont need to specify your SSH login each time:

    Host *.lisausa.net
      IdentityFile ~/.ssh/id_rsa
      User rlong

