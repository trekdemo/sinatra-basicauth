# Sinatra Basic Auth
Simple basic auth helper for Sinatra

## Usage

    require 'sinatra'
    require 'sinatra/basic_auth'
    basic_auth do
      realm 'Give me password!'
      username 'Frank'
      password 'changeme'
    end

    get '/' do
      'This is public'
    end

    get '/private' do
      require_basic_auth
      'This is private'
    end
