module Web
  module Controllers
    module Recipes
      class Show
        include Web::Action
        expose :recipe
        handle_exception EntryNotFound => 404

        def call(params)
          external_recipe = Clients::Contentful.entry(params[:id])
          @recipe = Recipe.new(external_recipe)
        end
      end
    end
  end
end
