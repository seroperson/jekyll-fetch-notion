# frozen_string_literal: true

module JekyllFetchNotion
  class CollectionGenerator < AbstractGenerator
    attr_reader :config

    def initialize(notion_resource:, plugin:, config:)
      super(
        notion_resource: notion_resource,
        plugin: plugin
      )
      @config = config
    end

    def generate
      @notion_resource.fetch.each do |page|
        make_doc(page)
        log_new_page(page)
      end
    end

    private

    def make_doc(page)
      FileCreator.new(make_path(page), make_md(page)).create!
    end

    def make_path(page)
      "#{@config["source"]}/_#{@notion_resource.collection_name}/#{make_filename(page)}"
    end

    def make_filename(page)
      if @notion_resource.collection_name == "posts"
        "#{date_for(page).strftime("%Y-%m-%d")}-#{Jekyll::Utils.slugify(page.title, mode: "latin")}.md"
      else
        "#{Jekyll::Utils.slugify(page.title, mode: "latin")}.md"
      end
    end

    def make_md(page)
      NotionToMd::Converter
        .new(page_id: page.id)
        .convert(frontmatter: true)
    end

    def log_new_page(page)
      Jekyll.logger.info("Jekyll Notion:", "Page => #{page.title}")
    end

    def date_for(page)
      # The "date" property overwrites the Jekyll::Document#data["date"] key
      # which is the date used by Jekyll to set the post date.
      Time.parse(page.props["date"]).to_date
    rescue TypeError, NoMethodError
      # Because the "date" property is not required,
      # it fallbacks to the created_time which is always present.
      Time.parse(page.created_time).to_date
    end
  end
end
