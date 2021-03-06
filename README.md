# CSV Hasher   

[![Build Status](https://travis-ci.org/gsingharoy/csv_hasher.svg?branch=master)](https://travis-ci.org/gsingharoy/csv_hasher)  [![Gem Version](https://badge.fury.io/rb/csv_hasher.svg)](http://badge.fury.io/rb/csv_hasher)

This is a useful utility to return arrays of hashes of a CSV input file instead of arrays of arrays supported by the CSV class of Ruby. 

## Installation
```shell
gem install csv_hasher
```

## Usage

```shell
require 'csv_hasher'
arr_of_hashes = CSVHasher.hashify('path/to/csv/file')
```

By default the header column names are converted to keys of the hashes. These keys are Ruby Symbols spider cased. If you want the header values to remain as key Strings then use

```shell
arr_of_hashes = CSVHasher.hashify('path/to/csv/file', { original_col_as_keys: true })
```

If you want your own keys then pass your keys as a parameter.

```shell
arr_of_hashes = CSVHasher.hashify('path/to/csv/file', { keys: custom_keys })
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-awesome-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-awesome-feature`)
5. Create new Pull Request
6. Relax and enjoy a beer
