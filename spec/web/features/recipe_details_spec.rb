# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'recipe details page' do
  let(:first_entry_id) { '4dT8tcb6ukGSIg2YyuGEOm' }

  let(:contentful_recipes_response) do
    File.read('spec/fixtures/contentful_recipes_response.json')
  end

  let(:url) do
    'https://cdn.contentful.com/spaces/test_space_id/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm'
  end

  context 'when the recipe is found' do
    it 'renders the page properly' do
      stub_request(:get, url).to_return(
        status: 200,
        body: contentful_recipes_response
      )

      visit "/recipes/#{first_entry_id}"

      expect(page.find('h2')).to have_content(
        'White Cheddar Grilled Cheese with Cherry Preserves & Basil'
      )

      expect(page.find('p.description')).to have_content(
        'Use delicious cheese and good quality bread'
      )
    end
  end

  context 'when the recipe is not found' do
    it 'renders the 404 page' do
      stub_request(:get, url)
        .to_return(status: 200, body: { 'sys': { 'type': 'Array' },
                                        'total': 0,
                                        'skip': 0,
                                        'limit': 100,
                                        'items': [] }.to_json)

      visit "/recipes/#{first_entry_id}"

      expect(page).to have_content('404')
    end
  end
end
