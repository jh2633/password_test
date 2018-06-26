require 'sinatra'
require_relative 'model/password'

class App < Sinatra::Base

  get '/' do
    erb :password_form
  end

  post '/password' do
    Password.new(params[:password]).strength
  end
end
