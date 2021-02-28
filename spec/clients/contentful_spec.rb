# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Clients::Contentful do
  let(:contentful_base_url) do
    "https://cdn.contentful.com/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/environments/master"
  end

  let(:contentful_recipes_response) do
    File.read('spec/fixtures/contentful_recipes_response.json')
  end

  let(:first_entry_id) { '4dT8tcb6ukGSIg2YyuGEOm' }

  describe '.entries' do
    it 'returns a list of entries from the external service' do
      stub_request(:get, contentful_base_url + '/entries?content_type=recipe&limit=100&skip=0')
        .to_return(status: 200, body: contentful_recipes_response)

      entries = described_class.entries('recipe')

      expect(entries.count).to eq(1)
      expect(entries.first.id).to eq(first_entry_id)
    end
  end

  describe '.entry' do
    context 'when the entry is found' do
      it 'returns an entry from the external service' do
        stub_request(:get, contentful_base_url + "/entries?sys.id=#{first_entry_id}")
          .to_return(status: 200, body: contentful_recipes_response)

        entry = described_class.entry(first_entry_id)

        expect(entry.id).to eq(first_entry_id)
      end
    end

    context 'when the entry is not found' do
      it 'raises an error' do
        stub_request(:get, contentful_base_url + "/entries?sys.id=#{first_entry_id}")
          .to_return(status: 200, body: { 'sys': { 'type': 'Array' },
                                          'total': 0,
                                          'skip': 0,
                                          'limit': 100,
                                          'items': [] }.to_json)

        expect { described_class.entry(first_entry_id) }.to raise_error(EntryNotFound)
      end
    end
  end
end
