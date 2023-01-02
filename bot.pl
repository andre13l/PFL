% make_move(+Difficulty, +GameState, +Player, -NewGameState)
% Player Predicate move belongs to logic.pl but needs to be together with the bot predicate
make_move('Player', GameState, PlayerS, NewGameState) :-
  Player = 'Player', format('~n~`*t ~a turn ~`*t~57|~n', [PlayerS]), 
  player_piece(PlayerS, A),
  choose_piece(GameState, X, Y),
  format('- Selected spot: X : ~d -- Y : ~w \n', [X,Y]),
  move(GameState, X, Y, A, NewGameState),
  skip_line.

% make_move1(+Difficulty, +GameState, +Player, -NewGameState)
% Player Predicate move belongs to logic.pl but needs to be together with the bot predicate
make_move1('Player', GameState, PlayerS, NewGameState) :-
  Player = 'Player', format('~n~`*t ~a turn ~`*t~57|~n', [PlayerS]), 
  read_inputs(10, X, Y),
  player_piece(PlayerS, A),
  format('- Selected spot: X : ~d -- Y : ~w \n', [X,Y]),
  move(GameState, X, Y, A, NewGameState),
  skip_line.


