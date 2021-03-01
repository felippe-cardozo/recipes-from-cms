module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action
        expose :internal_recipes, :next_page, :previous_page

        def call(params)
          external_recipes = Clients::Contentful.entries('recipe',
                                                         skip: skip(params),
                                                         limit: limit(params))

          @internal_recipes = external_recipes.map do |external_recipe|
            Recipe.new(external_recipe)
          end

          pagination = recipes_pagination(params, external_recipes)
          @next_page = pagination.next_page
          @previous_page = pagination.previous_page
        end

        private

        def recipes_pagination(params, external_recipes)
          Web::Helpers::RecipesPagination.new(limit: limit(params),
                                              skip: skip(params),
                                              total: external_recipes.total)
        end

        def skip(params)
          @skip ||=
            (params[:skip] || 0).to_i
        end

        def limit(params)
          @limit ||=
            (params[:limit] || ENV['CONTENTFUL_PAGINATION_LIMIT']).to_i
        end
      end
    end
  end
end
