RSpec.shared_examples "NOTION_TOKEN is not provided" do |notion_token|
  before do
    allow(ENV).to receive(:[]).with("NOTION_TOKEN").and_return(notion_token)

    VCR.use_cassette("notion_page") { JekyllFetchNotion::FetchCommand.process([], config) }
  end

  let(:notion_config) do
    {
      "pages" => [{
        "id" => "9dc17c9c-9d2e-469d-bbf0-f9648f3288d3"
      }]
    }
  end

  it "does not create an instance of Notion::Client" do
    expect(Notion::Client).not_to have_received(:new)
  end

  it "logs a warning" do
    expect(Jekyll.logger).to have_received(:warn).with("Jekyll Notion:",
      "NOTION_TOKEN not provided. Cannot read from Notion.")
  end
end
