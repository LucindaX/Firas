var Game = function(player1, player2, turn, mode=1){
  this.mode = mode // 1 (vs comp) 2 ( 2 players)
  this.players = [player1, player2];
  this.turn = (turn == "1" ? player1 : player2);
  this.originalTurn = this.turn
  this.board = new Board();
  if (this.mode == 1 && this.turn == player2) this.sync();
}
		

Game.prototype.switchTurn = function(){ 
	this.turn = this.turn === this.players[0] ? this.players[1] : this.players[0]
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
};

Game.prototype.new = function(){ return this.board.empty }

Game.prototype.stop = function(){ this.board.removeListeners(); }

Game.prototype.reset = function(){
	this.turn = this.originalTurn
  $("#game-notification").html("");
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
	this.board.clear();
	this.board.removeListeners();
	this.board.addListeners(this);
}

Game.prototype.notification = function(msg){
  $("#game-notification").html(msg);
}

Game.prototype.start = function(){
	this.board.addListeners(this);
	$("#player-turn").html(this.turn.name).css("color",this.turn.color);
	$("#game").show();
}

Game.prototype.sync = function(){
  this.board.freeze();
  var url = this.mode == 1 ? "/move" : "/state";
  var game = this;
  data =  { board: this.board.cells, player: this.turn.sign };
  $.ajax({
    type: "POST",
    url: url,
    data: JSON.stringify(data),
    dataType: "json"
  }).
  done(function(data){

    if( game.mode == 1 ){
      game.board.computerMove(data.move, game.turn);
      game.switchTurn();
    }

    if( data.state == 1 ){ //somebody won 
      var winner = data.winner == game.players[0].sign ? game.players[0] : game.players[1]
      game.notification(winner.name + " has won !");
      game.stop();
    }
    else if(data.state == 2){ // it's a draw
      game.notification("It's a draw !");
      game.stop();
    }

    game.board.unfreeze();

  }).
  fail(function(jqxhr, msg){
    console.log(msg);
  });
}
