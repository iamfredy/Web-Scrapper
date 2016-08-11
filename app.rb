#!/usr/bin/env ruby
require 'sinatra'
get'/' do
  "<form action='/result' method='post'>
    <input type='text' name='txtUrl'>
    <input type='submit' value='Submit Url' name='btnClick'>
  </form>"
end

post '/result' do
  "Hey"+params[:txtUrl].to_s
end