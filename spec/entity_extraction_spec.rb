# encoding: UTF-8

require 'spec_helper'

vcr_options = { 
  cassette_name: "entity_extraction", 
  record: :new_episodes, 
  match_requests_on: [:method, :uri, :body]
}

describe Dandelionapi::EntityExtraction, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <datatxt@mailinator.com>
      c.app_id = "e0bca290"
      c.app_key = "2294c676b8698383764514cc219fad92"
      c.endpoint = "https://api.dandelion.eu/"
      c.path = "datatxt/"
    end
  end
  
  # inizialization of the request

  it "initialize a new nex request" do
    request = Dandelionapi::EntityExtraction::Request.new
    expect(request).to be_an_instance_of(Dandelionapi::EntityExtraction::Request)
  end

  # correct request and response

  it "make a request to nex using italian plain text" do
    element = Dandelionapi::EntityExtraction::Request.new
    response = element.analyze(text: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio il bambino più grande mi mena davanti a tutti gli altri lui che passa per caso mi salva e mi condanna per sempre mio padre di spalle sul piatto si mangia la vita e poi sulla pista da ballo fa un valzer dentro il suo nuovo vestito  Per sempre solo per sempre cosa sarà mai porvarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente E lei che non si lascia afferrare si piega indietro e ride e lei che dice quanto mi ama e io che mi fido e lei che mi toccava per prima la sua mano bambina vuole che le giuri qualcosa le si gonfia una vena e lei che era troppo più forte sicura di tutto e prima di andarsene mi dà il profilo con un movimento perfetto Per sempre solo per sempre cosa sarà mai portarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente per sempre solo per sempre Mia madre che prepara la cena cantando sanremo carezza la testa a mio padre gli dice vedrai che ce la faremo Per sempre solo per sempre cosa sarà mai portarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente per sempre solo per sempre")
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("it")
    expect(response["annotations"]).to be_an_instance_of(Array)
    response["annotations"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["title"]).not_to be_nil
      expect(a["label"]).not_to be_nil
    end
  end

  it "make a request to nex using a blog url" do
    element = Dandelionapi::EntityExtraction::Request.new
    response = element.analyze(url: "http://blog.andreamostosi.name")
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("en")
    expect(response["annotations"]).to be_an_instance_of(Array)
    response["annotations"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["title"]).not_to be_nil
      expect(a["label"]).not_to be_nil
    end
  end

  it "make a request to nex using an HTML body" do
    element = Dandelionapi::EntityExtraction::Request.new
    response = element.analyze(html: '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"><html><head><title>403 Forbidden</title></head><body><h1>Forbidden</h1><p>You don t have permission to access /on this server.</p><p>Additionally, a 404 Not Founderror was encountered while trying to use an ErrorDocument to handle the request.</p></body></html>')
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("en")
    expect(response["annotations"]).to be_an_instance_of(Array)
    response["annotations"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["title"]).not_to be_nil
      expect(a["label"]).not_to be_nil
    end
  end

  it "make a request to nex using an HTML fragement" do
    element = Dandelionapi::EntityExtraction::Request.new
    response = element.analyze(html_fragment: "<h1>Questo è un test</h1>")
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("it")
    expect(response["annotations"]).to be_an_instance_of(Array)
    response["annotations"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["title"]).not_to be_nil
      expect(a["label"]).not_to be_nil
    end
  end

  # missing mandatory params

  it "raise MissingParameter exception when no params are given" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze({}) }.to raise_error(Dandelionapi::MissingParameter)
  end

  it "raise MissingParameter exception when required params are missing" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(other: "test") }.to raise_error(Dandelionapi::MissingParameter)
  end

  # wrong params format

  it "raise WrongParameterFormat exception on numeric text" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(text: 35) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on numeric url" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(url: 3.14) }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on unexistent lang" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(text: "text", lang: "wrong") }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  it "raise WrongParameterFormat exception on unexistent country" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(text: "text", country: "XX") }.to raise_error(Dandelionapi::WrongParameterFormat)
  end

  # too many mandatory params

  it "raise TooManyParameters exception when required params are missing" do
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(text: "test", url: "http://blog.andreamostosi.name") }.to raise_error(Dandelionapi::TooManyParameters)
  end

  # requesta params error

  it "raise BadResponse exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.app_id = "bad-app-id"
      c.app_key = "bad-app-key"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::EntityExtraction::Request.new
    expect { element.analyze(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end

end