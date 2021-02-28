# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recipe do
  describe '.new' do
    context 'when the external recipe has all modeled attributes' do
      it 'returns an entity with all attributes present' do
        external_recipe_struct = Struct.new(:title, :photo, :tags, :description, :chef, :id, :content_type)
        external_recipe = external_recipe_struct.new(
          'recipe title',
          OpenStruct.new(url: '//image.jpg'),
          [OpenStruct.new(name: 'vegan')],
          'recipe description',
          OpenStruct.new(name: 'Paola Carosella'),
          'fake_id',
          OpenStruct.new(id: 'recipe')
        )

        recipe = described_class.new(external_recipe)

        expect(recipe.title).to eq('recipe title')
        expect(recipe.description).to eq('recipe description')
        expect(recipe.image).to eq('//image.jpg')
        expect(recipe.tags).to eq(['vegan'])
        expect(recipe.chef_name).to eq('Paola Carosella')
        expect(recipe.id).to eq('fake_id')
      end
    end

    context 'when the external recipe has a missing attribute' do
      it 'keeps the same interface, setting the missing attributes to nil' do
        external_recipe_struct = Struct.new(:title, :description, :id, :content_type)
        external_recipe = external_recipe_struct.new('recipe title',
                                                     'recipe description',
                                                     'fake_id',
                                                     OpenStruct.new(id: 'recipe'))

        recipe = described_class.new(external_recipe)

        expect(recipe.title).to eq('recipe title')
        expect(recipe.description).to eq('recipe description')
        expect(recipe.id).to eq('fake_id')
        expect(recipe.image).to be_nil
        expect(recipe.chef_name).to be_nil
        expect(recipe.tags).to be_nil
      end
    end

    context 'when the object received is not a recipe' do
      it 'raises an exception' do
        external_recipe_struct = Struct.new(:title, :description, :id, :content_type)
        external_recipe = external_recipe_struct.new('recipe title',
                                                     'recipe description',
                                                     'fake_id',
                                                     OpenStruct.new(id: 'not_recipe'))

        expect { Recipe.new(external_recipe) }.to raise_error(ArgumentError, 'content_type must be recipe')
      end
    end
  end
end
