module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action
        expose :internal_recipes

        def call(_params)
          external_recipes = Clients::Contentful.entries('recipe')
          @internal_recipes = external_recipes.map do |external_recipe|
            Recipe.new(external_recipe)
          end
        end
      end
    end
  end
end
