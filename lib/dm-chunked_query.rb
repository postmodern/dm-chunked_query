require 'dm-chunked_query/mixin'
require 'dm-chunked_query/version'

require 'dm-core'

DataMapper::Model.send :include, DataMapper::ChunkedQuery::Mixin
DataMapper::Collection.send :include, DataMapper::ChunkedQuery::Mixin
