# frozen_string_literal: true

module JekyllFetchNotion
  class DatabaseFactory
    def self.for(notion_resource:, site:, plugin:)
      if notion_resource.data_name.nil?
        CollectionGenerator.new(
          notion_resource: notion_resource,
          site: site,
          plugin: plugin,
          config: site.config
        )
      else
        DataGenerator.new(
          notion_resource: notion_resource,
          site: site,
          plugin: plugin
        )
      end
    end
  end
end
