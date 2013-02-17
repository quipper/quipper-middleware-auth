require "quipper/middleware/auth/version"

module Quipper
  module Middleware
    module Auth
      class GoogleApps
        def initialize(app)
          @app = app
        end

        def call(env)
          request = Rack::Request.new(env)
          session = env['rack.session']

          if request.path == '/auth/g/callback'
            if auth = request.env['omniauth.auth']
              session[:google_apps_user_id] = auth['info']['email']
              return [302, {'Location' => '/'}, []]
            else
              redirect '/auth/failure'
            end
          end

          if request.path == '/auth/failure'
            return [401, {"Content-Type" => "text/html"}, "login failed"]
          end

          return [302, {'Location' => '/auth/g'}, []] if !session[:google_apps_user_id]
          @app.call(env)
        end
      end
    end
  end
end
