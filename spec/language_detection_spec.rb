# encoding: UTF-8

require 'spec_helper'

vcr_options = { 
  cassette_name: "language_detection", 
  record: :new_episodes, 
  match_requests_on: [:method, :uri, :body]
}

describe Dandelionapi::LanguageDetection, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <Dandelionapi@mailinator.com>
      c.token = "YOUR-TEST-TOKEN"
      c.endpoint = "https://api.dandelion.eu/"
      c.path = "datatxt"
    end
  end
  
  # initialization of the request

  it "initialize a new sim request" do
    request = Dandelionapi::LanguageDetection::Request.new
    expect(request).to be_an_instance_of(Dandelionapi::LanguageDetection::Request)
  end

  # correct request and response

  it "make a request to li using an italian plain texts" do
    element = Dandelionapi::LanguageDetection::Request.new
    response = element.analyze(text: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio il bambino più grande mi mena davanti a tutti gli altri lui che passa per caso mi salva e mi condanna per sempre")
    expect(response).not_to be_empty
    expect(response["detectedLangs"]).to be_an_instance_of(Array)
    response["detectedLangs"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["lang"]).not_to be_nil
    end
  end

  it "make a request to li using a blog url" do
    element = Dandelionapi::LanguageDetection::Request.new
    response = element.analyze(url: "https://www.cambridgeenglish.org/blog")
    expect(response).not_to be_empty
    expect(response["detectedLangs"]).to be_an_instance_of(Array)
    response["detectedLangs"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["lang"]).not_to be_nil
    end
  end

  it "make a request to li using an HTML error page" do
    element = Dandelionapi::LanguageDetection::Request.new
    response = element.analyze(html: '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"><html><head><title>403 Forbidden</title></head><body><h1>Forbidden</h1><p>You don t have permission to access /on this server.</p><p>Additionally, a 404 Not Founderror was encountered while trying to use an ErrorDocument to handle the request.</p></body></html>')
    expect(response).not_to be_empty
    expect(response["detectedLangs"]).to be_an_instance_of(Array)
    response["detectedLangs"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["lang"]).not_to be_nil
    end
  end

  it "make a request to li using an HTML fragment" do
    element = Dandelionapi::LanguageDetection::Request.new
    response = element.analyze(html_fragment: "<h1>Questo è un test</h1>")
    expect(response).not_to be_empty
    expect(response["detectedLangs"]).to be_an_instance_of(Array)
    response["detectedLangs"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["lang"]).not_to be_nil
    end
  end

  # missing mandatory params

  it "raise MissingParameter exception when required params are missing" do
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze({}) }.to raise_error(Dandelionapi::MissingParameter)
  end

  it "raise MissingParameter exception when required params are missing" do
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze(other: "test") }.to raise_error(Dandelionapi::MissingParameter)
  end

  # wrong params format

  it "raise WrongParameterFormat exception on numeric text" do
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze(text: 35) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on numeric url" do
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze(url: 3.14) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on wrong clean param" do
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze(text: "text", clean: "wrong") }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  # requesta params error

  it "raise BadResponse exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.token = "bad-token"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::LanguageDetection::Request.new
    expect { element.analyze(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end



end