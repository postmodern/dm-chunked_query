module DataMapper
  module ChunkedQuery
    class Chunks

      include Enumerable

      # The number of resources per chunk
      attr_reader :per_chunk

      def initialize(query,per_chunk)
        @query = query
        @per_chunk = per_chunk
      end

      def [](key)
        case key
        when Range
          if (key.min >= 0 && key.min < length)
            if (key.max >= 0 && key.max < length)
              resources = []

              key.each do |index|
                chunk(index).each { |resource| resources << resource }
              end

              resources
            end
          end
        when Integer
          if (key >= 0 && key < length)
            chunk(key)
          end
        end
      end

      alias at []

      def each
        return enum_for(:each) unless block_given?

        (0...length).each do |index|
          yield chunk(index)
        end

        return self
      end

      def count
        @count ||= @query.count
      end

      def length
        @length ||= (count.to_f / @per_chunk).ceil
      end

      alias size length

      protected

      def chunk(index)
        @query.all(
          :limit => @per_chunk,
          :offset => (index * @per_chunk)
        )
      end

    end
  end
end
