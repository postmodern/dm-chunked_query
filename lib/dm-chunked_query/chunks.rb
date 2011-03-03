module DataMapper
  module ChunkedQuery
    #
    # Represents the abstract collection of Chunks.
    #
    class Chunks

      include Enumerable

      # The number of resources per chunk
      attr_reader :per_chunk

      #
      # Creates a new collection of Chunks.
      #
      # @param [DataMapper::Model, DataMapper::Collection] query
      #   The model or collection to access via chunks.
      #
      # @param [Integer] per_chunk
      #   The number of records per-chunk.
      #
      def initialize(query,per_chunk)
        @query = query
        @per_chunk = per_chunk
      end

      #
      # Provides random access to chunks.
      #
      # @param [Range<Integer>, Integer] key
      #   The index or range of indices to access.
      #
      # @return [DataMapper::Collection, nil]
      #   A collection of resources at the given index or indices.
      #   If the index is out of bounds, `nil` will be returned.
      #
      def [](key)
        case key
        when Range
          index = key.first
          span = key.to_a.size

          chunk_at(index,span)
        when Integer
          chunk_at(index)
        end
      end

      #
      # Accesses a chunk at a specific index.
      #
      # @param [#to_i] index
      #   The index to access.
      #
      # @return [DataMapper::Collection, nil]
      #   The chunk of resources at the given index. If the index is out of
      #   bounds, `nil` will be returned.
      #
      def at(index)
        chunk_at(key.to_i)
      end

      #
      # Enumerates over each chunk in the collection of Chunks.
      #
      # @yield [chunk]
      #   The given block will be passed each chunk.
      #
      # @yieldparam [DataMapper::Collection] chunk
      #   The collection of resources that makes up a chunk.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator object will be returned.
      #
      def each
        return enum_for(:each) unless block_given?

        (0...length).each do |index|
          yield chunk_at(index)
        end

        return self
      end

      #
      # Counts how many underlying resources are available.
      #
      # @return [Integer]
      #   The total number of resources.
      #
      def count
        @count ||= @query.count
      end

      #
      # Calculate the number of Chunks.
      #
      # @return [Integer]
      #   The number of available Chunks.
      #
      def length
        @length ||= (count.to_f / @per_chunk).ceil
      end

      alias size length

      protected

      #
      # Creates a chunk of resources.
      #
      # @param [Integer] index
      #   The index of the chunk.
      #
      # @param [Integer] span
      #   The number of chunks the chunk should span.
      #
      # @return [DataMapper::Collection]
      #   The collection of resources that makes up the chunk.
      #
      def chunk_at(index,span=1)
        if (index >= 0 && index < length)
          @query[(index * @per_chunk), (span * @per_chunk)]
        end
      end

    end
  end
end
