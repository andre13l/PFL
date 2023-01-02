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
  turn1(GameState, Player1Type, 'Player 1', Player2Type),
  write('GAME OVER'),
  menu.

% turn1(+GameState, +Player, +PlayerS, +NextPlayer)
% Turn1 predicate for moving a piece
turn1(GameState, Player, PlayerS, NextPlayer):-
  make_move(Player, GameState, PlayerS, NewGameState),
  player_swap(PlayerS,EnemyS),
  clear, 
  display_game(NewGameState),
  turn(NewGameState, NextPlayer, EnemyS, Player, 2).

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

