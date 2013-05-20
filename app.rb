require 'json'
require 'sinatra/base'
require './favcon'
require 'em-http-promise'
require 'sinatra-promises'
require 'byebug'
require 'debugger'
require 'nokogiri'

class App < Sinatra::Base
  use Favcon
  get '/' do
    {
      hello: "World"
    }.to_json
  end

  get '/async' do
    query = params[:query] || 'Hello'
    EM::HttpRequest.new("http://www.google.com/search?q=#{query}").get.then { |result|
      {
        result: Nokogiri::HTML(result.response).at_css('.s cite').to_s.gsub(/<\/?[^>]*>/, '').gsub(/\n\n+/, "\n").gsub(/^\n|\n$/, '')
      }.to_json
    }
  end
end