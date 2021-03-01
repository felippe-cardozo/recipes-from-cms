# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'list recipes page' do
  let(:contentful_recipes_response) do
    File.read('spec/fixtures/contentful_recipes_full_response.json')
  end

  let(:contentful_recipes_first_page) do
    File.read('spec/fixtures/contentful_recipes_first_page.json')
  end

  let(:contentful_recipes_second_page) do
    File.read('spec/fixtures/contentful_recipes_second_page.json')
  end

  let(:base_url) do
    'https://cdn.contentful.com/spaces/test_space_id/environments/master/entries?content_type=recipe'
  end

  let(:details_url) do
    'https://cdn.contentful.com/spaces/test_space_id/environments/master/entries?sys.id=4dT8tcb6ukGSIg2YyuGEOm'
  end

  it 'renders the recipes list page' do
    stub_request(:get, "#{base_url}&limit=2&skip=0").to_return(
      status: 200,
      body: contentful_recipes_first_page
    )

    visit '/recipes'

    expect(page).to have_content('Recipes')
    expect(page).to have_selector('div.recipe', count: 2)
  end

  context 'when I click on details button' do
    it 'redirects me to details page' do
      stub_request(:get, "#{base_url}&limit=2&skip=0").to_return(
        status: 200,
        body: contentful_recipes_first_page
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

  context 'when navigating between next and previous pages' do
    it 'allows me to go back and forward' do
      stub_request(:get, "#{base_url}&limit=2&skip=0").to_return(
        status: 200,
        body: contentful_recipes_first_page
      )
      stub_request(:get, "#{base_url}&limit=2&skip=2").to_return(
        status: 200,
        body: contentful_recipes_second_page
      )

      visit '/recipes'
      first_page_html = page.html

      expect(page).to have_content('Next Page')
      expect(page).to_not have_content('Previous Page')

      find('button.next_page_button').click_link

      expect(page.current_path).to eq('/recipes')
      expect(page.html).to_not eq(first_page_html)
      expect(page).to_not have_content('Next Page')
      expect(page).to have_content('Previous Page')

      find('button.previous_page_button').click_link

      expect(page.current_path).to eq('/recipes')
      expect(page.html).to eq(first_page_html)
      expect(page).to have_content('Next Page')
    end
  end
end
