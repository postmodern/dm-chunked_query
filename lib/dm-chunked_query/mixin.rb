require 'dm-chunked_query/chunks'

module DataMapper
  module ChunkedQuery
    module Mixin
      #
      # Allows chunked access to the resources from a query.
      #
      # @param [Integer] per_chunk
      #   The number of resources per-chunk.
      #
      # @return [Chunks]
      #   The abstract collection of chunks from the query.
      #
      def chunks(per_chunk)
        Chunks.new(self,per_chunk)
      end
    end
  end
end
