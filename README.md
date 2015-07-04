# [![Ruby Gem Icon](https://raw.githubusercontent.com/zenkay/dandelionapi-ruby/master/rubygem.png)](https://rubygems.org/gems/dandelionapi) Dandelion API Ruby Gem

[![Code Climate](https://codeclimate.com/github/zenkay/dandelionapi-ruby/badges/gpa.svg)](https://codeclimate.com/github/zenkay/dandelionapi-ruby) [![Travis CI](https://travis-ci.org/zenkay/dandelionapi-ruby.svg?branch=master)](https://travis-ci.org/zenkay/dandelionapi-ruby) [![Gem Version](https://badge.fury.io/rb/dandelionapi.svg)](http://badge.fury.io/rb/dandelionapi) [![Coverage Status](https://codeclimate.com/github/zenkay/dandelionapi-ruby/coverage)](https://codeclimate.com/github/zenkay/dandelionapi-ruby/badges/coverage.svg)

## Installation

Add this line to your application's Gemfile:

```
gem 'dandelionapi'
```

And then execute:

```
$ bundle install
```
## Setup

Setup configuration parameters

```
Dandelionapi.configure do |c|
  c.app_id = "your-app-id-for-dandelionapi-account"
  c.app_key = "your-app-key-for-dandelionapi-account"
  c.endpoint = "https://api.dandelion.eu/"
end
```

## Usage

_Methods references are taken from [Dandelion API's documentation](https://dandelion.eu/docs/)._

**[Entity Extraction API](https://dandelion.eu/docs/api/datatxt/nex/v1/)**: is a named entity extraction & linking API that performs very well even on short texts, on which many other similar services do not. dataTXT-NEX currently works on English, French, German, Italian and Portuguese texts. With this API you will be able to automatically tag your texts, extracting Wikipedia entities and enriching your data.

```
element = Dandelionapi::EntityExtraction.new
response = element.analyze(text: "This is a test")
```

**[Text Similarity API](https://dandelion.eu/docs/api/datatxt/sim/v1/)**: is a semantic sentence similarity API optimized on short sentences. With this API you will be able to compare two sentences and get a score of their semantic similarity. It works even if the two sentences don't have any word in common.

```
element = Dandelionapi::TextSimilarity.new
response = element.analyze(text1: "This is a test", text2: "This is another test")
```

**[Language Detection API](https://dandelion.eu/docs/api/datatxt/li/v1/)**: is a simple language identification API; it is a tool that may be useful when dealing with texts, so we decided to open it to all our users. It currently supports more than 50 languages.

```
element = Dandelionapi::LanguageDetection.new
response = element.analyze(text: "Questo è un test")
```
