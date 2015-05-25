# csv_hasher

CSV Hasher

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

By default the header column names are converted to keys of the hashes. If you want your own keys then pass the keys as a parameter

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