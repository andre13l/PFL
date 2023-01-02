% make_move(+Difficulty, +GameState, +Player, -NewGameState)
% Player Predicate move belongs to logic.pl but needs to be together with the bot predicate
make_move('Player', GameState, PlayerS, NewGameState) :-
  write('- Where do you want to place your piece?.\n'),
  read_inputs(10, X, Y),
  format('- Selected spot: X : ~d -- Y : ~w \n', [X,Y]),
  move(GameState, X, Y, NewGameState),
  skip_line.


