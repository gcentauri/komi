require 'roda'
require_relative 'lib/main'

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect '/hello'
    end

    # /hello branch
    r.on 'hello' do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello'

      # GET /hello/world request
      r.get 'world' do
        "#{@greeting} world!"
      end

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting}!"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end

    r.on 'komi' do
      @komi = Komi.new(File.expand_path('./assets'))

      r.is do
        r.get do
          output = ""
          @komi.all_players.each do |p|
            output += "</br>#{p.name}</br> "
          end
          output
        end
      end
    end
  end
end

run App.freeze.app
