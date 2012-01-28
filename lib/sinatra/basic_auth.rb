require 'sinatra/base'

module Sinatra

  class AuthenticationSettings

    def initialize app, &blk
      @app = app
      instance_eval &blk
    end

    %w[ username password realm ].each do |param|
      class_eval %[
        def #{param} val, &blk
          @app.set :basic_auth_#{param}, val
        end
      ]
    end

  end

  module Helpers
    class Authentication
      attr_accessor :request, :app
      def initialize( app, request )
        self.app = app
        self.request = request
      end

      def auth
        @basic_auth ||= Rack::Auth::Basic::Request.new( request.env )
      end

      def unauthorized!
        app.headers 'WWW-Authenticate' => %(Basic realm="#{settings.basic_auth_realm}")
        throw :halt, [ 401, 'Authorization Required' ]
      end

      def bad_request!
        throw :halt, [ 400, 'Bad Request' ]
      end

      def authorized?
        request.env['REMOTE_USER']
      end

      def authorize( username, password )
        settings.basic_auth_username == username &&
        settings.basic_auth_password == password
      end
    end

    def require_basic_auth
      a = Authentication.new( self, request )
      return if a.authorized?
      a.unauthorized! unless a.auth.provided?
      a.bad_request!  unless a.auth.basic?
      a.unauthorized! unless a.authorize( *a.auth.credentials )
      request.env['REMOTE_USER'] = a.auth.username
    end

  end

  module BasicAuth

    def basic_auth &block
      AuthenticationSettings.new(self, &block)
    end

    def self.registered( app )
      app.set :basic_auth_realm, 'You need to authenticate yourself!'
      app.set :basic_auth_username, 'Frank'
      app.set :basic_auth_password, 'changeme'

      app.helpers Helpers
    end

  end

  register BasicAuth
end

