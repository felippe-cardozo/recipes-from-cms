module Web
  module Helpers
    class RecipesPagination
      def initialize(skip:, limit:, total:)
        @skip = skip
        @limit = limit
        @total = total
      end

      def previous_page
        return nil if @skip.zero?

        previous_page_skip = [@skip - @limit, 0].max
        OpenStruct.new(limit: @limit, skip: previous_page_skip)
      end

      def next_page
        current_recipes_count = @skip + @limit
        recipes_left_count = @total - current_recipes_count

        return nil if recipes_left_count < 1

        OpenStruct.new(limit: @limit, skip: @skip + @limit)
      end
    end
  end
end
