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
      # @param [Integer, Range<Integer>] key
      #   The index or range of indices to access.
      #
      # @return [DataMapper::Collection, Array<DataMapper::Resource>]
      #   A collection of resources at the given index or indices.
      #
      def [](key)
        case key
        when Range
          if (key.min >= 0 && key.min < length)
            if (key.max >= 0 && key.max < length)
              chunks = nil

              key.each do |index|
                if chunks
                  chunks |= chunk(index)
                else
                  chunks = chunk(index)
                end
              end

              chunks
            end
          end
        when Integer
          if (key >= 0 && key < length)
            chunk(key)
          end
        end
      end

      alias at []

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
          yield chunk(index)
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
      # @return [DataMapper::Collection]
      #   The collection of resources that makes up the chunk.
      #
      def chunk(index)
        @query.all(
          :limit => @per_chunk,
          :offset => (index * @per_chunk)
        )
      end

    end
  end
end
