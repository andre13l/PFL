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
  turn(GameState, Player1Type, 'Player 1', Player2Type, 100).

% turn(+GameState, +Player, +PlayerS, +NextPlayer, +N)
% Turn predicate for moving a piece
turn(GameState, Player, PlayerS, NextPlayer, N):-
  make_move(Player, GameState, PlayerS, NewGameState),
  clear, 
  display_game(NewGameState),
  opposed_opponent_string(PlayerS, EnemyS).
  S is N-1,
  turn(NewGameState, NextPlayer, EnemyS, Player).

% game_over(+GameState, +Player , -Winner)
% checks first if enemy is winner
game_over(GameState, CurrentPlayer, EnemyS):-
  opposed_opponent_string(CurrentPlayer, EnemyS),
  check_win(EnemyS, GameState, 10).
% then checks if player is the winner
game_over(GameState, CurrentPlayer, CurrentPlayer):-
  check_win(CurrentPlayer, GameState, 10).
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

% does one floodfill and doesnt repeat on redo
attemp_flood_fill(Board, X, Y, NewBoard):-

  floodFill(Board, 10, X, Y, 0, 9, NewBoard), !.
% prolog implementation of the floodFill algorithm
floodFill(Board, BoardSize, X, Y, PrevCode, NewCode, FinalBoard):-
  X >= 0, X < BoardSize, Y >= 0, Y < BoardSize,
  value_in_board(Board, X, Y, PrevCode),
  replace(Board, X, Y, NewCode, BoardResult), % replaces PrevCode by NewCode
  X1 is X+1, X2 is X-1, Y1 is Y+1, Y2 is Y-1,
  floodFill(BoardResult, BoardSize, X1, Y, PrevCode, NewCode, T1) ,
  floodFill(T1, BoardSize, X2, Y, PrevCode, NewCode, T2) ,
  floodFill(T2, BoardSize, X, Y1, PrevCode, NewCode, T3) ,  
  floodFill(T3, BoardSize, X, Y2, PrevCode, NewCode, FinalBoard).
% if initial floodfill returns from every direction, returns the initial board
floodFill(Board, _, _, _, _, _, Board).