# encoding: UTF-8

require 'spec_helper'

vcr_options = { :cassette_name => "entity_extraction", :record => :new_episodes }

describe Dandelionapi::EntityExtraction, vcr: vcr_options do

  before(:each) do
    Dandelionapi.configure do |c|
      # account: Mario Rossi <datatxt@mailinator.com>
      c.app_id = "e0bca290"
      c.app_key = "2294c676b8698383764514cc219fad92"
      c.endpoint = "https://api.dandelion.eu/"
    end
  end
  
  it "initialize a new nex request" do
    request = Dandelionapi::EntityExtraction.new
    expect(request).to be_an_instance_of(Dandelionapi::EntityExtraction)
  end

  it "make a request to nex using italian plain text" do
    element = Dandelionapi::EntityExtraction.new
    response = element.analyze(
      text: "Mio padre che mi spinge a mangiare e guai se non finisco mio padre che vuol farmi guidare mi frena con il fischio il bambino più grande mi mena davanti a tutti gli altri lui che passa per caso mi salva e mi condanna per sempre mio padre di spalle sul piatto si mangia la vita e poi sulla pista da ballo fa un valzer dentro il suo nuovo vestito  Per sempre solo per sempre cosa sarà mai porvarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente E lei che non si lascia afferrare si piega indietro e ride e lei che dice quanto mi ama e io che mi fido e lei che mi toccava per prima la sua mano bambina vuole che le giuri qualcosa le si gonfia una vena e lei che era troppo più forte sicura di tutto e prima di andarsene mi dà il profilo con un movimento perfetto Per sempre solo per sempre cosa sarà mai portarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente per sempre solo per sempre Mia madre che prepara la cena cantando sanremo carezza la testa a mio padre gli dice vedrai che ce la faremo Per sempre solo per sempre cosa sarà mai portarvi dentro solo tutto il tempo per sempre solo per sempre c'è un istante che rimane lì piantato eternamente per sempre solo per sempre"
    )
    expect(response).not_to be_empty
    expect(response["lang"]).to eq("it")
    expect(response["annotations"]).to be_an_instance_of(Array)
    response["annotations"].each do |a|
      expect(a["confidence"]).not_to be_nil
      expect(a["title"]).not_to be_nil
      expect(a["label"]).not_to be_nil
    end
  end

  it "raise BadResponse exception on wrong config parameters" do
    Dandelionapi.configure do |c|
      c.app_id = "bad-app-id"
      c.app_key = "bad-app-key"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Dandelionapi::EntityExtraction.new
    expect { element.analyze(text: "test") }.to raise_error(Dandelionapi::BadResponse)
  end

  it "raise MissingParameters exception when required params are missing" do
    element = Dandelionapi::EntityExtraction.new
    expect { element.analyze(other: "test") }.to raise_error(Dandelionapi::MissingParameters)
  end
end