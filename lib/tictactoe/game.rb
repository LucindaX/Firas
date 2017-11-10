module Tictactoe

	class Game
    attr_reader :winner
		def initialize(board=nil)
			@board = board || Board.new
			@p1 = "X"
			@p2 = "O"
			@winner = nil
		end

		def next_move(sign)
			@turn = @p1 == sign ? @p1 : @p2
			minimax(@turn)
		end

		def state
			state = over?
			if state == @p1 || state == @p2
				@winner = state
				1
			elsif state
				2
			else
				3
			end
		end

		def play(n)
			@board.check(@turn, n)
		end

		private
		
		def reset
			@board.reset
		end

		def switch_turn
			@turn = ( @turn == @p1 ? @p2 : @p1 )
		end

		def possible_moves
			@board.empty_cells
		end

		def won?(sign=@turn)

			@board.diagonals.each do |diagonal|
				return true if diagonal.all? { |v| v == sign } 
			end
			@board.rows.each do |row|
				return true if row.all? { |v| v == sign }
			end
			@board.columns.each do |column|
				return true if column.all? { |v| v == sign }
			end
			false
		end

		def over?
			# check if somebody won
			@board.diagonals.each do |diagonal|
				return diagonal.first if diagonal.compact.length == 3 && diagonal.uniq.length == 1 
			end
			@board.rows.each do |row|
				return row.first if row.compact.length == 3 && row.uniq.length == 1
			end
			@board.columns.each do |column|
				return column.first if column.compact.length == 3 && column.uniq.length == 1
			end
			# check if full and nobody won (ie: draw)
			@board.full?
		end

		def minimax(sign, depth=0)
			
			return score(depth) if over?
			
			scores = []
			moves = []
			
			possible_moves.each do |move|
				@board.check(sign, move)
				scores << minimax(sign == @p1 ? @p2 : @p1, depth+1 )
				moves << move
				@board.reset(move)
			end 
			
      if sign == @turn
				max_index = scores.each_with_index.max[1]
				return depth == 0 ? moves[max_index] : scores[max_index]
			else
				return scores.min
			end
		
		end

		def score(depth=0)
			return 10-depth if won?(@turn)
			return depth-10 if won?(@turn == "X" ? "O" : "X")
			0
		end

	end
end
