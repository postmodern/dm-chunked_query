require 'dm-chunked_query/mixin'

require 'dm-core'

DataMapper::Model.send :include, DataMapper::ChunkedQuery::Mixin
DataMapper::Collection.send :include, DataMapper::ChunkedQuery::Mixin
