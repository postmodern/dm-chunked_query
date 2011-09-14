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
      def initialize(query, per_chunk)
        @query = query
        @per_chunk = per_chunk

        if key = query.key and (key.size != 1 || !key.respond_to?(:max))
          raise "Your model must have a single primary key which is a DataMapper::Property::Serial object."
        end

        if order = query.query.order and direction = order.first
          if order.size != 1 || direction.operator != :asc || direction.target != query.key.first
            raise "You can't specify the order, it's forced to be #{batch_order.order}"
          end
        end
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

        relation = @query.all(batch_order).all(:limit => @per_chunk)
        records = relation.all(primary_key.name.gte => 0)

        while records.any?
          yield records

          break if records.size < @per_chunk

          if primary_key_offset = records.last.key.first
            records = relation.all(primary_key.name.gt => primary_key_offset)
          else
            raise "Primary key not included in the custom select clause"
          end
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

      def batch_order
        @query.all(:order => @query.key).query
      end

      def primary_key
        @query.key.first
      end

    end
  end
end
