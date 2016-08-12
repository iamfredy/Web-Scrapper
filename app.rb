#!/usr/bin/env ruby
require 'sinatra'
require 'net/http'
require 'openssl'
require 'open-uri'
require 'nokogiri'
require 'json'

get'/' do #Home Page
  "
  <br><hr><br>
  <form action='/result' method='post'> 
    <label for='txtUrl'>Enter URL :</label>
    <input type='text' name='txtUrl' id='txtUrl' required>
    <input type='submit' value='Submit Url' name='btnClick'>
  </form><br><hr><br>
  "
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
  @out={}
  @out['h1']=[]
  @out['h2']=[]
  @out['h3']=[]
  @out['h4']=[]
  @out['links']=[]

  docs=doc.xpath("//a").map{|link| link['href'].to_s}
  links=docs.select{|i| (i.start_with?('https','http'))}
  links.each{|link| @out['links'][@out['links'].size]=link}

  headers_h1= doc.xpath("//h1").map{|header| header.text}
  headers_h1.each{|i| @out['h1'][@out['h1'].size]=i.strip}
  
  headers_h2= doc.xpath("//h2").map{|header| header.text}
  headers_h2.each{|i| @out['h2'][@out['h2'].size]=i.strip}

  headers_h3= doc.xpath("//h3").map{|header| header.text}
  headers_h3.each{|i| @out['h3'][@out['h3'].size]=i.strip}

  headers_h4= doc.xpath("//h4").map{|header| header.text}
  headers_h4.each{|i| @out['h4'][@out['h4'].size]=i.strip}
  content_type:json
  return (JSON.pretty_generate(@out))
end