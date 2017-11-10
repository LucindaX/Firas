$LOAD_PATH.push File.dirname(__FILE__)

require 'sinatra/base'
require 'tictactoe/board'
require 'tictactoe/game'
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
    data = parse request.body.read
    
    bad_request if data["player"].nil?
    return { move: 5, state: 3 }.to_json if data["board"].empty?
    
    board = Tictactoe::Board.new(data["board"])
    game = Tictactoe::Game.new(board)
    
    # check if game is over before requesting next move
    state = game.state
    
    if state == 1
      return { state: 1, winner: game.winner }.to_json
    elsif state == 2
      return { state: 2 }.to_json
    end

    { move: game.next_move(data["player"]) , state: 3 }.to_json

  end

  helpers ApplicationHelpers

end
