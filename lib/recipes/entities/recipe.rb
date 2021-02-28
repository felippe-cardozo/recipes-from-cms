# frozen_string_literal: true

# Internal representation of a Marley Spoon's recipe.
class Recipe
  attr_reader :title, :image, :tags, :description, :chef_name, :id

  def initialize(external_recipe)
    validate!(external_recipe)

    @title = external_recipe.title
    @description = external_recipe.description
    @id = external_recipe.id
    @image = get_safely(external_recipe, :photo)&.url
    @tags = get_safely(external_recipe, :tags)&.map { |tag| tag.name }
    @chef_name = get_safely(external_recipe, :chef)&.name
  end

  private

  def get_safely(object, attribute)
    object.send(attribute) if object.respond_to?(attribute)
  end

  def validate!(external_recipe)
     if external_recipe.content_type.id != 'recipe'
       raise ArgumentError.new('content_type must be recipe')
     end
  end
end
