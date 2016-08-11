#!/usr/bin/env ruby
require 'sinatra'
require 'net/http'
require 'openssl'
require 'open-uri'
require 'nokogiri'

get'/' do #Home Page
  "<form action='/result' method='post'> 
    Enter URL<input type='text' name='txtUrl' required>
    <input type='submit' value='Submit Url' name='btnClick'>
  </form>"
end

post '/result' do
  get_page(params[:txtUrl].to_s)
end

def get_page(url)
  begin
    doc = Nokogiri::HTML(open(url))
  rescue
     return "<h1>Oops..Could not Fetch the URL</h1>"
  end
  links   = doc.xpath("//a").map{|link| link['href'].to_s+"<br>"}
  headers = doc.xpath("//h1","//h2").map{|header| header.to_s+"<br>"}
  return "<h1><u>Headers</u></h1>"+headers.join+"<h1><u>Links</u></h1><b>"+links.join
end






