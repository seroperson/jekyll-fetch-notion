# frozen_string_literal: true

require "jekyll"
require "notion"
require "notion_to_md"
require "logger"
require "jekyll-fetch-notion/commands/fetch_notion"

NotionToMd::Logger.level = Logger::ERROR

Notion.configure do |config|
  config.token = ENV["NOTION_TOKEN"]
end

module JekyllFetchNotion
  autoload :DatabaseFactory, "jekyll-fetch-notion/factories/database_factory"
  autoload :AbstractGenerator, "jekyll-fetch-notion/generators/abstract_generator"
  autoload :CollectionGenerator, "jekyll-fetch-notion/generators/collection_generator"
  autoload :AbstractNotionResource, "jekyll-fetch-notion/abstract_notion_resource"
  autoload :NotionDatabase, "jekyll-fetch-notion/notion_database"
  autoload :FileCreator, "jekyll-fetch-notion/file_creator"
end
