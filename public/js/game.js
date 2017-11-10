var Game = function(player1, player2, turn, mode=1){
  this.mode = mode // 1 (vs comp) 2 ( 2 players)
  this.cells = {};
  this.players = [player1, player2];
  this.turn = turn === 1 ? player1 : player2 ;
  this.originalTurn = this.turn
  this.board = new Board();
}
		

Game.prototype.switchTurn = function(){ 
	this.turn = this.turn === this.players[0] ? this.players[1] : this.players[0]
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
};

Game.prototype.new = function(){ return this.board.empty }

Game.prototype.stop = function(){ this.board.removeListeners(); }

Game.prototype.reset = function(){
	this.turn = this.originalTurn
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
	this.board.clear();
	this.board.removeListeners();
	this.board.addListeners(this);
}

Game.prototype.start = function(){
	this.board.addListeners(this);
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
	$("#game").show();
}
