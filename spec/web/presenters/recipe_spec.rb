# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Presenters::Recipe do
  describe '.new' do
    it 'builds the recipe for presentation' do
      internal_recipe = OpenStruct.new(description: '# description',
                                       title: 'title',
                                       chef_name: 'chef name',
                                       tags: ['vegan'],
                                       image: '//link.com',
                                       id: 'fake_id')

      presentation_recipe = described_class.new(internal_recipe)

      expect(presentation_recipe.description.strip).to eq('<h1>description</h1>')
      expect(presentation_recipe.title).to eq('title')
      expect(presentation_recipe.chef_name).to eq('chef name')
      expect(presentation_recipe.tags).to eq(['vegan'])
      expect(presentation_recipe.image).to eq('https://link.com')
      expect(presentation_recipe.details_link).to eq('/recipes/fake_id')
    end
  end
end
