require "quipper/middleware/auth/version"

module Quipper
  module Middleware
    module Auth
      class GoogleApps
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(env)
          return @app.call(env) if @options[:whitelist] && @options[:whitelist].include?(env["HTTP_X_FORWARDED_FOR"])

          request = Rack::Request.new(env)
          session = env['rack.session']

          @options[:mounted] ||= ""

          if request.path == "#{@options[:mounted]}/auth/#{@options[:name]}/callback"
            if auth = request.env['omniauth.auth']
              session[:google_apps_user_id] = auth['info']['email']
              return [302, {'Location' => "#{@options[:mounted]}/"}, []]
            else
              redirect "#{@options[:mounted]}/auth/failure"
            end
          end

          if request.path == "#{@options[:mounted]}/auth/failure"
            return [401, {"Content-Type" => "text/html"}, "login failed"]
          end

          return [302, {'Location' => "#{@options[:mounted]}/auth/#{@options[:name]}"}, []] if !session[:google_apps_user_id]
          @app.call(env)
        end
      end
    end
  end
end
