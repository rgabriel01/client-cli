# README

# client-cli

## Prerequisites
Ruby version 3 and up

## Starting dev environment

### Installing ruby (using rbenv but not exclusively so)
```bash
rbenv install 3.1.4
```
### Installing bundler
```bash
gem install bundler
```
### Install gems and dependencies
```bash
bundle install
```

### To access the help menu
This displays all the available settings
```bash
$ ruby bin/client_cli.rb -h
```
### To start searching by name
This process search the datasource for the matching name passed
```bash
$ ruby bin/client_cli.rb -m search -q john
```

### To check the datasource for duplicates on email addresses
This process checks the datasource for all instances of duplicating email addresses
```bash
$ ruby bin/client_cli.rb -m check
```
### Assumptions
When working on this project, the datasources is an outside source not local to the current implementation.
Hence the classes `check` and `search` as well as the controller class `client_manager` allows for `data_source` to be injectible.

Both classes `check` and `search` are designed in such a way that only outputs processed data and hold no presentation attributes

For the presentation attributes, we rely on the `client_manager` class which displays the results in stdout.
Both classes `check` and `search` are also designed in a way that say we move this to an api kind of structure, we can easily still reuse the latter and use them inside controllers as they are independent classes with every dependency injected to it.

### Limitations
The `search` class is very rigid for now as it only is able to search by `full_name`. What would be an improvement here is to be able to add the ability to search different fields as well.

The `check` class is rigid as well, currently, it only supports the `email` to stack on the duplicates, could be on the `full_name` as well
