# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'list recipes page' do
  let(:contentful_recipes_response) do
    File.read('spec/fixtures/contentful_recipes_full_response.json')
  end

  let(:url) do
    'https://cdn.contentful.com/spaces/test_space_id/environments/master/entries?content_type=recipe&limit=100&skip=0'
  end

  let(:details_url) do
    'https://cdn.contentful.com/spaces/test_space_id/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm'
  end

  it 'renders the page properly' do
    stub_request(:get, url).to_return(
      status: 200,
      body: contentful_recipes_response
    )

    visit '/recipes'

    expect(page).to have_content('Recipes')
    expect(page).to have_selector('div.recipe', count: 4)
  end

  it 'links to the details page' do
    stub_request(:get, url).to_return(
      status: 200,
      body: contentful_recipes_response
    )

    stub_request(:get, details_url).to_return(
      status: 200,
      body: contentful_recipes_response
    )

    visit '/recipes'

    button = find_all('button').first
    button.click_link

    expect(page.current_path).to match(/\/recipes\/.+/)
  end
end
