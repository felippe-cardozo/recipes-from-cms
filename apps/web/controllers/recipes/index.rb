module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action
        expose :recipes

        def call(_params)
          external_recipes = Clients::Contentful.entries('recipe')
          @recipes = external_recipes.map do |external_recipe|
            Recipe.new(external_recipe)
          end
        end
      end
    end
  end
end
