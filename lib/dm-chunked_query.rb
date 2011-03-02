require 'dm-chunked_query/chunked'

require 'dm-core'

DataMapper::Collection.send :include, DataMapper::ChunkedQuery::Mixin
