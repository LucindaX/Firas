$(function(){
  $("#game-mode select").on("change",function(){
    var container = $("#player-names")
    container.html("");

    if($(this).val() === "1"){
      container.
      append("Enter Your Name: <input type='text' name='player1'><br>");
    }
    else{
      container.
      append("Enter Player 1 Name: <input type='text' name='player1'><br><br>").
      append("Enter Player 2 Name: <input type='text' name='player2'><br>");
    }
  });

  $(document).on("click", "#play-game", function(){
    var inputs = $("#player-names input");
    var mode = 1;
    if (inputs.length == 2){
      var opponent_name = inputs.last().val().replace(/\s+/g, '') || "Player 2"
      mode = 2;
    }
    var player_name = inputs.first().val().replace(/\s+/g, '') || "Player 1"
    var player = new Player(player_name, "X", "#B22");
    var opponent = new Player((opponent_name || "Computer"), "O", "#00F" );
    var starting = $("#starting-player").val();
    var game = new Game(player, opponent, starting, mode);
    $("#game-setup").hide();
    $("#reset-game").on('click', function(){ game.reset(); })
    game.start();
  })
});

