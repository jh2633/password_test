require 'sinatra'
require_relative 'password'


get '/' do
  erb :password_form
end

post '/password' do
  Password.new(params[:password]).strength
end
