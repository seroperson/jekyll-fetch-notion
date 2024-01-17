# frozen_string_literal: true

module JekyllFetchNotion
  class AbstractGenerator
    def initialize(notion_resource:, plugin:)
      @notion_resource = notion_resource
      @plugin = plugin
    end

    def generate
      raise "Do not use the AbstractGenerator class. Implement the generate method in a subclass."
    end

    def resource_id
      @notion_resource.id
    end
  end
end
