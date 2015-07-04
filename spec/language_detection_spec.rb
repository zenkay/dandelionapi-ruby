require 'spec_helper'

vcr_options = { :cassette_name => "language_detection", :record => :new_episodes }

describe Dandelionapi::LanguageDetection, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <Dandelionapi@mailinator.com>
      c.app_id = "e0bca290"
      c.app_key = "2294c676b8698383764514cc219fad92"
      c.endpoint = "https://api.dandelion.eu/"
    end
  end
  
  it "initialize a new sim request" do
    request = Dandelionapi::LanguageDetection.new
    expect(request).to be_an_instance_of(Dandelionapi::LanguageDetection)
  end

  it "make a request to li using an italian plain texts" do
    element = Dandelionapi::LanguageDetection.new
    response = element.analyze(
      text: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio il bambino più grande mi mena davanti a tutti gli altri lui che passa per caso mi salva e mi condanna per sempre",
    )
    expect(response).not_to be_empty
    expect(response["detectedLangs"]).to be_an_instance_of(Array)
    response["detectedLangs"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["lang"]).not_to be_nil
    end
  end

  it "raise exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.app_id = "bad-app-id"
      c.app_key = "bad-app-key"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::LanguageDetection.new
    expect { element.analyze(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end


end