# [![Ruby Gem Icon](https://raw.githubusercontent.com/zenkay/dandelionapi-ruby/master/rubygem.png)](https://rubygems.org/gems/dandelionapi) Dandelion API Ruby Gem

[![Code Climate](https://codeclimate.com/github/zenkay/dandelionapi-ruby/badges/gpa.svg)](https://codeclimate.com/github/zenkay/dandelionapi-ruby) [![Travis CI](https://travis-ci.org/zenkay/dandelionapi-ruby.svg?branch=master)](https://travis-ci.org/zenkay/dandelionapi-ruby) [![Gem Version](https://badge.fury.io/rb/dandelionapi.svg)](http://badge.fury.io/rb/dandelionapi) [![Coverage Status](https://coveralls.io/repos/zenkay/dandelionapi-ruby/badge.svg)](https://coveralls.io/r/zenkay/dandelionapi-ruby)

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

**[Entity Extraction API](https://dandelion.eu/docs/api/datatxt/nex/v1/)**: This is a named entity extraction & linking API that performs very well even on short texts, on which many other similar services do not. It currently works on English, French, German, Italian and Portuguese texts. With this API you will be able to automatically tag your texts, extracting Wikipedia entities and enriching your data.

```
element = Dandelionapi::EntityExtraction.new
response = element.analyze(text: "This is a test")
```

**[Text Similarity API](https://dandelion.eu/docs/api/datatxt/sim/v1/)**: This API is a semantic sentence similarity API optimized on short sentences. With this API you will be able to compare two sentences and get a score of their semantic similarity. It works even if the two sentences don't have any word in common.

```
element = Dandelionapi::TextSimilarity.new
response = element.analyze(text1: "This is a test", text2: "This is another test")
```

**[Language Detection API](https://dandelion.eu/docs/api/datatxt/li/v1/)**: 
Language Detection API is a simple language identification API; it is a tool that may be useful when dealing with texts, so we decided to open it to all our users. It currently supports more than 96 languages.

```
element = Dandelionapi::LanguageDetection.new
response = element.analyze(text: "Questo è un test")
```

**[Sentiment Analysis API](https://dandelion.eu/docs/api/datatxt/sent/v1/)**: This API analyses a text and tells whether the expressed opinion is positive, negative, or neutral. Given a short sentence, it returns a label representing the identified sentiment, along with a numeric score ranging from strongly positive (1.0) to extremely negative (-1.0).

```
element = Dandelionapi::SentimentAnalysis.new
response = element.analyze(text: "I'm really disappointed")
```

## About the DandelionAPI project

This library is part of a larger group of libraries used to explore best strategies to build packages among multiple languages. Each library is written using conventions about coding style, filesystem structure, testing, documentation and distribution typical of the language enviroment but preserve the library main concepts. This version use the following conventions for the **Ruby** environment:

- Tested using [RSpec](http://rspec.info/)
- Documented using [YARD](http://yardoc.org/)
- Packed using [Bundler](http://bundler.io/) and [Gem](https://rubygems.org/)
- Distributed over [RubyGems](https://rubygems.org/) as [dandelionapi](https://rubygems.org/gems/dandelionapi)

----

Here is the complete list of libraries available: [Ruby](https://github.com/zenkay/dandelionapi-ruby), [PHP](https://github.com/zenkay/dandelionapi-php), [Node](https://github.com/zenkay/dandelionapi-node)
