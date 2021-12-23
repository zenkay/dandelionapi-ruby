# encoding: UTF-8

require 'spec_helper'

vcr_options = { 
  cassette_name: "sentiment_analysis", 
  record: :new_episodes, 
  match_requests_on: [:method, :uri, :body]
}

describe Dandelionapi::SentimentAnalysis, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <datatxt@mailinator.com>
      c.token = "YOUR-TEST-TOKEN"
      c.endpoint = "https://api.dandelion.eu/"
      c.path = "datatxt"
    end
  end
  
  # initialization of the request

  it "initialize a new nex request" do
    request = Dandelionapi::SentimentAnalysis::Request.new
    expect(request).to be_an_instance_of(Dandelionapi::SentimentAnalysis::Request)
  end

  # correct request and response

  it "make a request to sent using italian plain text" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    response = element.analyze(text: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio")
    expect(response).not_to be_empty
    expect(response["sentiment"]).not_to be_empty
    expect(response["sentiment"]["score"]).to be >= -1.0
    expect(response["sentiment"]["score"]).to be <= 1.0
    expect(["positive", "neutral", "negative"]).to include(response["sentiment"]["type"])
  end

  it "make a request to sent using a blog url" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    response = element.analyze(url: "https://www.cambridgeenglish.org/blog")
    expect(response).not_to be_empty
    expect(response["sentiment"]).not_to be_empty
    expect(response["sentiment"]["score"]).to be >= -1.0
    expect(response["sentiment"]["score"]).to be <= 1.0
    expect(["positive", "neutral", "negative"]).to include(response["sentiment"]["type"])
  end

  it "make a request to sent using an HTML error page" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    response = element.analyze(html: '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"><html><head><title>403 Forbidden</title></head><body><h1>Forbidden</h1><p>You don t have permission to access /on this server.</p><p>Additionally, a 404 Not Founderror was encountered while trying to use an ErrorDocument to handle the request.</p></body></html>')
    expect(response).not_to be_empty
    expect(response["sentiment"]).not_to be_empty
    expect(response["sentiment"]["score"]).to be >= -1.0
    expect(response["sentiment"]["score"]).to be <= 1.0
    expect(["positive", "neutral", "negative"]).to include(response["sentiment"]["type"])
  end

  it "make a request to sent using an HTML fregment" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    response = element.analyze(html_fragment: "<h1>Questo è un test</h1>")
    expect(response).not_to be_empty
    expect(response["sentiment"]).not_to be_empty
    expect(response["sentiment"]["score"]).to be >= -1.0
    expect(response["sentiment"]["score"]).to be <= 1.0
    expect(["positive", "neutral", "negative"]).to include(response["sentiment"]["type"])
  end

  # missing mandatory params

  it "raise MissingParameter exception when required params are missing" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze({}) }.to raise_error(Dandelionapi::MissingParameter)
  end

  it "raise MissingParameter exception when required params are missing" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze(other: "test") }.to raise_error(Dandelionapi::MissingParameter)
  end

  # wrong params format

  it "raise WrongParameterFormat exception on numeric text" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze(text: 35) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on numeric url" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze(url: 3.14) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on unexistent lang" do
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze(text: "text", lang: "wrong") }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  # requesta params error

  it "raise BadResponse exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.token = "bad-token"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::SentimentAnalysis::Request.new
    expect { element.analyze(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end

end