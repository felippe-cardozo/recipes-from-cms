module Web
  module Views
    module Recipes
      class Show
        include Web::View

        def recipe
          Web::Presenters::Recipe.new(internal_recipe)
        end
      end
    end
  end
end
