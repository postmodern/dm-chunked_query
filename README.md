# dm-chunked_query

* [Source](https://github.com/postmodern/dm-chunked_query)
* [Issues](https://github.com/postmodern/dm-chunked_query/issues)
* [Documentation](http://rubydoc.info/gems/dm-chunked_query/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Allows performing chunked queries on DataMapper Models or Collections.

## Features

* Allows random-access to chunks within a query.
* Can iterate through all chunks within a query.
* Can be used for bulk-processing of resources.
* Can also be used for pagination of resources.

## Examples

Enumerate over all chunks, 20 resources per-chunk:

    require 'dm-chunked_query'

    MyModel.each_chunk(20) do |chunk|
      chunk.each do |resource|
        # ...
      end
    end

Get the 5th chunk, containing 10 resources:

    MyModel.all(:foo => 'bar').chunks(10)[5]

Process records in batches:

    MyModel.batch(100) do |resource|
      # ...
    end

## Requirements

* [dm-core](https://github.com/datamapper/dm-core#readme) ~> 1.0
* [dm-aggregates](https://github.com/datamapper/dm-aggregates#readme) ~> 1.0

## Install

    $ gem install dm-chunked_query

## Copyright

Copyright (c) 2011 Hal Brodigan

See {file:LICENSE.txt} for details.
