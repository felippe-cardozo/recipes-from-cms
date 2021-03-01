module Web
  module Presenters
    class Recipe
      include Hanami::Helpers::EscapeHelper

      attr_reader :title, :description, :image, :tags, :chef_name, :details_link

      def initialize(object)
        @title = object.title
        @description = markdown_to_html(object.description)
        @image = formated_image(object.image)
        @tags = object.tags
        @chef_name = object.chef_name
        @details_link = "/recipes/#{object.id}"
      end

      private

      def markdown_to_html(description)
        raw(Redcarpet::Markdown.new(Redcarpet::Render::HTML)
                               .render(description))
      end

      def formated_image(image)
        if image&.start_with?('//')
          "https:#{image}"
        else
          image
        end
      end
    end
  end
end
