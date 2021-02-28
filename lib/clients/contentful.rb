# frozen_string_literal: true

class EntryNotFound < StandardError; end

module Clients
  class Contentful
    def self.client
      ::Contentful::Client.new(
        space: ENV['CONTENTFUL_SPACE_ID'],
        access_token: ENV['CONTENTFUL_ACCESS_TOKEN']
      )
    end

    def self.entries(content_type, skip: 0, limit: 100)
      client.entries(content_type: content_type, skip: skip, limit: limit)
    end

    def self.list(content_type:, skip: 0, limit: 100)
      client.entries(content_type: content_type, skip: skip, limit: limit)
    end

    def self.entry(id)
      entry = client.entry(id)
      raise EntryNotFound unless entry

      entry
    end
  end
end
