% play/0
% main predicate for game start, presents the main menu
play :-
  clear,
  proj_logo,
  menu.

% start_game(+GameState, +Player1Type, +Player2Type)
% starts a game with Player1Type vs Player2Type
/*start game*/
start_game(GameState, Player1Type, Player2Type):-
  clear, 
  display_game(GameState),
  turn1(GameState, Player1Type, 'Player 1', Player2Type, 99),
  write('GAME OVER'),
  menu.

% turn1(+GameState, +Player, +PlayerS, +NextPlayer, +N)
% Turn1 predicate for moving a piece
turn1(GameState, Player, PlayerS, NextPlayer, N):-
  make_move(Player, GameState, PlayerS, NewGameState),
  player_swap(PlayerS,EnemyS),
  clear, 
  display_game(NewGameState),
  turn(NewGameState, NextPlayer, EnemyS, Player, N).

% turn(+GameState, +Player, +PlayerS, +NextPlayer, +N)
% Turn predicate for moving a piece
turn(GameState, Player, PlayerS, NextPlayer, N):-
  make_move(Player, GameState, PlayerS, NewGameState),
  player_swap(PlayerS,EnemyS),
  clear, 
  display_game(NewGameState),
  N>0,
  S is N-1,
  turn(NewGameState, NextPlayer, EnemyS, Player, S).

% game_over(+GameState, +Player , -Winner)
% checks first if enemy is winner
game_over(GameState, CurrentPlayer, EnemyS):-
  size_of_board(GameState, Size), 
  opposed_opponent_string(CurrentPlayer, EnemyS),
  check_win(EnemyS, GameState, Size).
% then checks if player is the winner
game_over(GameState, CurrentPlayer, CurrentPlayer):-
  size_of_board(GameState, Size),
  check_win(CurrentPlayer, GameState, Size).
% in case there is no winner, 'none' is returned
game_over(_, _, 'none').

% check_win(+PlayerS, +GameState, +K, -Result)
% to check the win for Player 1, we can check the win for Player 1 with the transposed matrix
check_win('Player 2', GameState, X):-
  transpose(GameState, Transpose),
  check_win('Player 1', Transpose, X).

check_win('Player 1', GameState, Size):-
  value(GameState, 'Player 1', Value),
  Value == Size.

