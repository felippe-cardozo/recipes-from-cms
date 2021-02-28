module Web
  module Controllers
    module Recipes
      class Show
        include Web::Action
        expose :internal_recipe
        handle_exception EntryNotFound => 404

        def call(params)
          external_recipe = Clients::Contentful.entry(params[:id])
          @internal_recipe = Recipe.new(external_recipe)
        end
      end
    end
  end
end
