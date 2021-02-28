# frozen_string_literal: true

get '/',            to: 'recipes#index'
get '/recipes',     to: 'recipes#index'
get '/recipes/:id', to: 'recipes#show'
