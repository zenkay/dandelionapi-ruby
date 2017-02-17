# encoding: UTF-8

require 'spec_helper'

vcr_options = { :cassette_name => "text_similarity", :record => :new_episodes }

describe Dandelionapi::TextSimilarity, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <datatxt@mailinator.com>
      c.token = "YOUR-TEST-TOKEN"
      c.endpoint = "https://api.dandelion.eu/"
      c.path = "datatxt/"
    end
  end
  
  it "initialize a new sim request" do
    request = Dandelionapi::TextSimilarity.new
    expect(request).to be_an_instance_of(Dandelionapi::TextSimilarity)
  end

  it "make a request to sim using two italian plain texts" do
    element = Dandelionapi::TextSimilarity::Request.new
    response = element.compare(
      text1: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio il bambino più grande mi mena davanti a tutti gli altri lui che passa per caso mi salva e mi condanna per sempre",
      text2: "Mio padre di spalle sul piatto si mangia la vita e poi sulla pista da ballo fa un valzer dentro il suo nuovo vestito"
    )
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("it")
    expect(response["similarity"]).not_to be_nil
  end

  it "raise exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.token = "bad-token"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::TextSimilarity::Request.new
    expect { element.compare(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end


end