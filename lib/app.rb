$LOAD_PATH.push File.dirname(__FILE__)

require 'sinatra/base'
require 'tictactoe/board'
require 'helpers/application_helpers'

class App < Sinatra::Base

  set :root, File.expand_path('../..', __FILE__)
  
  set :public_folder, "#{root}/public"

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  post '/move' do
    # { board: { '1': 'X', .... }, player: 'O' }
    content_type :json
  end

  helpers ApplicationHelpers

end
