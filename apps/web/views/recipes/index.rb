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
      end
    end
  end
end
