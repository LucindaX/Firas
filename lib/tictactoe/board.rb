module Tictactoe
	
	class Board
		attr_reader :size, :board	
		
		def initialize(board=nil)
			@size = 3
			@board = Array.new(3) { |i| Array.new(3) }
			@map = {}
			index = 1
			for i in 0..@size-1
				for j in 0..@size-1
					@map[index] = [i,j]
					index += 1
				end
			end
			build(board) if board
		end

		def build(board)
			#{1: 'X', 2:'O', ....}
			board.each do |key, val|
				check(val, key.to_i)
			end
		end

		def element(n)
			i, j = @map[n]
			@board[i][j]
		end
		
		def check(val, n)
			if element(n)
				false
			else
				i, j = @map[n]
				@board[i][j] = val
			end
		end
		
		def reset(n=nil)
			if n
				i, j = @map[n]
				@board[i][j] = nil
			else
				@board = Array.new(@size) { |i| Array.new(@size) }
			end
		end

		def full?
			for n in 1..@size**2
				return false if element(n).nil?
			end
			true
		end

		def empty_cells
			cells = []
			for n in 1..@size**2
				cells << n if element(n).nil?
			end
			cells
		end

		def diagonals
			[ 
				[element(1), element(5), element(9)], 
				[element(3), element(5), element(7)]
			]
		end
		def rows
			[
				[element(1), element(2), element(3)],
				[element(4), element(5), element(6)],
				[element(7), element(8), element(9)]
			]
		end
		def columns
			[
				[element(1), element(4), element(7)],
				[element(2), element(5), element(8)],
				[element(3), element(6), element(9)]
			]
		end
	end
end
