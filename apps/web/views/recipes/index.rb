module Web
  module Views
    module Recipes
      class Index
        include Web::View

        def recipes
          internal_recipes.map do |recipe|
            Web::Presenters::Recipe.new(recipe)
          end
        end

        def next_page_link
          "/recipes?limit=#{next_page.limit}&skip=#{next_page.skip}" if next_page
        end

        def previous_page_link
          "/recipes?limit=#{previous_page.limit}&skip=#{previous_page.skip}" if previous_page
        end
      end
    end
  end
end
