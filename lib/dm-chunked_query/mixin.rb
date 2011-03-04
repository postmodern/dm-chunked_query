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

      #
      # Enumerate over every chunk.
      #
      # @param [Integer] per_chunk
      #   The number of resources per-chunk.
      #
      # @yeild [chunk]
      #   A chunk of resources within the query.
      #
      # @yieldparam [DataMapper::Collection] chunk
      #   A collection of resources that makes up the chunk.
      #
      # @return [Chunks]
      #   The abstract collection of chunks from the query.
      #
      # @since 0.2.0
      #
      def each_chunk(per_chunk,&block)
        chunks.each(&block)
      end
    end
  end
end
