require 'dm-chunked_query/chunks'

module DataMapper
  module ChunkedQuery
    module Mixin
      def chunks(per_chunk)
        Chunks.new(self,per_chunk)
      end
    end
  end
end
