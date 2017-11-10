var Board = function(){
	this.cells = {};
}

Board.prototype.update = function(i, val){
	this.cells[i] = val
}

Board.prototype.empty = function(){ return JQuery.isEmptyObject(this.cells); }


Board.prototype.addListeners = function(game){
	var board = this;
	$("td").one("click", function(){
		$(this).find("div").html(game.turn.sign).css("color", game.turn.color);
		var cellNumber = $(this).attr("id").split('_')[1];
		board.update(cellNumber, game.turn.sign);
  	game.switchTurn();  
    game.sync();	
	});
};

Board.prototype.computerMove = function(i, player){
  $("#cell_"+i).find("div").html(player.sign).css("color", player.color);
  this.update(i, player.sign);
}

Board.prototype.freeze = function(){
	$("td").css('pointer-events','none');
}
Board.prototype.unfreeze = function(){
	$("td").css('pointer-events', 'visible');
}

Board.prototype.removeListeners = function(){
	$("td").off();
}

Board.prototype.clear = function(){ 
	$("td").find("div").html("");
	this.cells = {}; 
}
